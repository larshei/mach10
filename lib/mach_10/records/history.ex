defmodule Mach10.Records.History do
  use Agent
  require Logger

  @state_file_base_name "history"
  @state_file_folder "./state"

  def start_link(_) do
    initial_state = read_persisted_state_file()

    Logger.debug("Starting #{__MODULE__}.")

    Process.flag(:trap_exit, true)

    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def get_history(id) do
    Agent.get(__MODULE__, fn state -> state.history end)
  end

  def add(record) do
    Agent.update(__MODULE__, fn %{history: history} = state ->
      history = [record | history] |> Enum.take(20)

      state |> Map.put(:history, history)
    end)
  end

  @impl true
  def terminate(reason, state) do
    Logger.info("Exiting Customer Fleet for #{state.fleet_name} with reason #{inspect reason}.")

    persist_state_to_disk(state)

    reason
  end

  defp persist_state_to_disk(state) do
    Logger.info "Persisting State for #{__MODULE__}'."

    path = "#{@state_file_folder}/#{@state_file_base_name}"

    case File.mkdir_p(@state_file_folder) do
      :ok ->
        Logger.info("Writing #{path}.dat")
        File.write!("#{path}.dat", :erlang.term_to_binary(state))
        :ok

      {:error, reason} ->
        Logger.error("Could not create data folder #{@state_file_folder}: #{reason}")
        :error

    end
  end

  defp read_persisted_state_file() do
    file_path = "#{@state_file_folder}/#{@state_file_base_name}.dat"

    case File.read(file_path) do
      {:error, _reason} ->
        Logger.error("#{__MODULE__} could not read persisted state, creating new state.")
        %{history: []}
      {:ok, file_data} ->
        :erlang.binary_to_term(file_data)
    end
  end

end
