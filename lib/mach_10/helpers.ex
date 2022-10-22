defmodule Mach10.Helpers do
  def utc_now_no_usec() do
    %{DateTime.utc_now() | microsecond: {0, 0}}
  end
end
