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
    with {:ok, %Record{} = record} <- Records.create_record(record_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.record_path(conn, :show, record))
        |> render("show.json", record: record)
    end
  end

  def show(conn, %{"track_id" => track_id, "user_id" => user_id}) do
    record = Records.get_record!(track_id, user_id)
    render(conn, "show.json", record: record)
  end

  def update(conn, %{"track_id" => track_id, "user_id" => user_id, "record" => record_params}) do
    record = Records.get_record!(track_id, user_id)

    with {:ok, %Record{} = record} <- Records.update_record(record, record_params) do
      render(conn, "show.json", record: record)
    end
  end

  def delete(conn, %{"track_id" => track_id, "user_id" => user_id}) do
    record = Records.get_record!(track_id, user_id)

    with {:ok, %Record{}} <- Records.delete_record(record) do
      send_resp(conn, :no_content, "")
    end
  end
end
