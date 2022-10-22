defmodule Mach10.Cldr do
  @moduledoc """
  CLDR is the "Common Language Data Repository".

  It contains information on how to format dates, times, numbers, names, languages and a lot more.
  """
  use Cldr,
    locales: ["en"],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime],
    default_locale: "en"
end
