defmodule Mach10Web.RecordController do
  use Mach10Web, :controller

  alias Mach10.Records
  alias Mach10.Records.Record

  action_fallback Mach10Web.FallbackController

  def index(conn, _params) do
    records = Records.list_records()
    render(conn, "index.json", records: records)
  end

  def create(conn, record_params) do
    current_record = Records.get_record(record_params["track_id"], record_params["user_id"])

    {status, record} = insert_record(current_record, record_params) |> IO.inspect()

    conn
    |> put_status(status)
    |> put_resp_header("location", Routes.record_path(conn, :show, record.track_id, record.user_id))
    |> render("show.json", record: record)
  end

  defp insert_record(nil, new_record_params) do
    with {:ok, %Record{} = record} <- Records.create_record(new_record_params) do
      {:created, record}
    end
  end

  defp insert_record(%Record{time_ms: old_time}, %{"time_ms" => new_time} = new_record_params) when new_time < old_time do
    with {:ok, %Record{} = record} <- Records.create_record(new_record_params) do
      {:ok, record}
    end
  end

  defp insert_record(old_record, _bad_new_record) do
    {:conflict, old_record}
  end

  def show(conn, %{"track_id" => track_id, "user_id" => user_id}) do
    record = Records.get_record(track_id, user_id)
    render(conn, "show.json", record: record)
  end

  def update(conn, %{"track_id" => track_id, "user_id" => user_id, "record" => record_params}) do
    record = Records.get_record(track_id, user_id)

    with {:ok, %Record{} = record} <- Records.update_record(record, record_params) do
      render(conn, "show.json", record: record)
    end
  end

  def delete(conn, %{"track_id" => track_id, "user_id" => user_id}) do
    record = Records.get_record(track_id, user_id)

    with {:ok, %Record{}} <- Records.delete_record(record) do
      send_resp(conn, :no_content, "")
    end
  end
end
