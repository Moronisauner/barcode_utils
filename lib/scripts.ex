defmodule Scripts do
  alias PaymentsBarcode.{Boleto, GDA}

  @bank_codes ["197", "033", "237", "473"]

  @spec gerar_boleto(Integer.t(), String.t() | nil) :: Boleto.t()

  def gerar_boleto(value \\ 100, due_date \\ nil) do
    %Boleto{
      bank_code: Enum.random(@bank_codes),
      currency_code: "9",
      free_field: random_free_field(),
      value: value,
      due_date: due_date || Date.utc_today()
    }
  end

  @spec gerar_concessionaria(Integer.t()) :: GDA.t()
  def gerar_concessionaria(value \\ 100) do
    %GDA{
      company_id: "0313",
      segment_id: "9",
      free_field: random_free_field(),
      value: value,
      value_type: :effective,
      verification_method: :mod10
    }
  end

  @spec linha_digitavel(Boleto.t() | GDA.t()) :: String.t()
  def linha_digitavel(documento), do: PaymentsBarcode.to_written_code(documento)

  @spec gerar_linha_digitaveis(Integer.t(), :boleto) :: [Boleto.t()]
  def gerar_linha_digitaveis(n, :boleto) do
    Enum.map(1..n, fn _ ->
      linha_digitavel(gerar_boleto())
    end)
  end

  @spec gerar_linha_digitaveis(Integer.t(), :concessionaria) :: [GDA.t()]
  def gerar_linha_digitaveis(n, :concessionaria) do
    Enum.map(1..n, fn _ ->
      linha_digitavel(gerar_concessionaria())
    end)
  end

  @spec gerar_linha_digitaveis(Integer.t(), :mix) :: [GDA.t() | Boleto.t()]
  def gerar_linha_digitaveis(n, :mix) do
    Enum.map(1..n, fn _ ->
      [true, false]
      |> Enum.random()
      |> if do
        gerar_boleto()
      else
        gerar_concessionaria()
      end
      |> linha_digitavel()
    end)
  end

  defp random_free_field do
    1_000_000_000_000_000_000_000_000..9_999_999_999_999_999_999_999_999
    |> Enum.random()
    |> Integer.to_string()
  end
end
