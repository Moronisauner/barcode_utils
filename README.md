# Scripts

Conjunto de funções para criar codigos de barras de boletos e concessionaria.
Lembrando que os boletos criados por esses scripts não são registrados e só são pagáveis em sandbox.

## Requisitos

Masta ter o elixir instalado e instalar as dependencias.

### Instalando as Dependencias
```shell
mix deps get
```

## Como Usar

Basta usar o `iex -S mix` para isso e usar as funções.
```elixir
iex(1)> Scripts.gerar_boleto
%PaymentsBarcode.Boleto{
  bank_code: "237",
  currency_code: "9",
  due_date: ~D[2019-06-27],
  free_field: "7320303242814306633124335",
  value: 100
}
iex(2)> Scripts.gerar_boleto(8000)
%PaymentsBarcode.Boleto{
  bank_code: "237",
  currency_code: "9",
  due_date: ~D[2019-06-27],
  free_field: "8292200425425916229102216",
  value: 8000
}
iex(3)> Scripts.gerar_boleto(8000, "2019-01-07")
%PaymentsBarcode.Boleto{
  bank_code: "237",
  currency_code: "9",
  due_date: "2019-01-07",
  free_field: "8392017622189172964066629",
  value: 8000
}
iex(4)> boleto = Scripts.gerar_boleto(8000, "2019-01-07") 
%PaymentsBarcode.Boleto{
  bank_code: "197",
  currency_code: "9",
  due_date: "2019-01-07",
  free_field: "7192630309269714370168469",
  value: 8000
}        

iex(5)> Scripts.linha_digitavel(boleto)
"19797192653030926971743701684698100000000008000"
   
iex(6)> Scripts.gerar_linha_digitaveis(5, :boleto)
["03396159995224336169900783769656879330000000100",
 "47396948855332510410624271371361179330000000100",
 "47395056440571045467866461006398979330000000100",
 "47395367226315983399388798282567279330000000100",
 "19793246453651832970502231340445179330000000100"]
iex(7)> Scripts.gerar_linha_digitaveis(5, :concessionaria)
["896500000006010003132395136881207437555084344939",
 "896200000009010003133120094608573377580093487040",
 "896600000005010003134417308941265610149518070268",
 "896500000006010003136974103169435304338067660542",
 "896500000006010003134243316360341903336032635235"]
iex(8)> Scripts.gerar_linha_digitaveis(5, :mix)           
["896500000006010003135216235701673461650839783786",
 "896500000006010003131173815379732945959951674446",
 "896200000009010003131652929455466128908210539072",
 "19798467205090088312095342555810179330000000100",
 "896100000000010003137535550148316635500849434591"]
iex(9)> 
```