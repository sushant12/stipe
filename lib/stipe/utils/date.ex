defmodule Stipe.Utils.Date do
  @moduledoc """
  Date utilities
  """

  @doc """
  Returns date in the format 01 Jan, 2019.

  ## Examples

      iex> format_date(~D[2000-01-01])
      01 Jan, 2000

  """
  def format_date(%Date{day: day, month: month, year: year}) do
    "#{format_day(day)} #{format_month(month)}, #{year}"
  end

  defp format_day(day) when day < 10, do: "0#{day}"
  defp format_day(day), do: "#{day}"

  defp format_month(1), do: "Jan"
  defp format_month(2), do: "Feb"
  defp format_month(3), do: "Mar"
  defp format_month(4), do: "Apr"
  defp format_month(5), do: "May"
  defp format_month(6), do: "Jun"
  defp format_month(7), do: "Jul"
  defp format_month(8), do: "Aug"
  defp format_month(9), do: "Sep"
  defp format_month(10), do: "Oct"
  defp format_month(11), do: "Nov"
  defp format_month(12), do: "Dec"
end
