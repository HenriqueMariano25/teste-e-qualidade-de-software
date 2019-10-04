require 'minitest/autorun'
require_relative 'moeda'

class MoedaTest < Minitest::Test
  include Moeda

  def test_formatacao_de_inteiro
    assert_equal "R$4,00", numero_para_moeda(4)
  end

  def test_formatacao_de_float
    assert_equal "R$7,50", numero_para_moeda(7.5)
  end

  def test_formatacao_de_string
    assert_equal "R$9,60", numero_para_moeda("9.6")
  end

  def test_uso_de_delimitadores_para_numeros_grandes
    assert_equal "R$3-500,00", numero_para_moeda(3_500, delimitador: "-")
  end

  def test_ausencia_de_delimitadores_em_numeros_pequenos
    assert_equal "R$5.650,00", numero_para_moeda(5_650)
  end

  def test_mudanca_da_unidade
    assert_equal "$50,00", numero_para_moeda(50, unidade: "$")
  end

  def test_mudanca_da_precisao
    assert_equal "R$75,00000", numero_para_moeda(75, precisao: 5)
  end

  def test_ausencia_de_separador_quando_precisao_for_0
    assert_equal "R$49.590", numero_para_moeda(49_590, precisao: 0)
  end

  def test_mudanca_do_delimitador
    assert_equal "R$37*102*230,00",numero_para_moeda(37_102_230, delimitador: "*")
  end

  def test_mudanca_do_separador
    assert_equal "R$21|00", numero_para_moeda(21, separador: "|")
  end

  def test_multiplas_opcoes_de_formatacao_simultaneamente
    assert_equal "¢90--000--000/00000", numero_para_moeda(90_000_000, unidade: "¢",
    precisao: 5, delimitador: "--", separador: "/")
  end
end
