unit uPessoa;

interface

uses uEnumCrud,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TPessoa = class
    private
      FCodigo: integer;
      FNome : string;
      FRG: string;
      FDataNascimento: string;
      FCEP: integer;
      FLogradouro: string;
      FComplemento: string;
      FBairro: string;
      FCidade: string;
      FUF: string;
      FNumero: string;
      FEnumerador: EnumTipoCrud;
    public
      property Codigo: integer read FCodigo write FCodigo;
      property Nome: string read FNome write FNome;
      property RG: string read FRG write FRG;
      property DataNascimento: string read FDataNascimento write FDataNascimento;
      property CEP: integer read FCEP write FCEP;
      property Logradouro: string read FLogradouro write FLogradouro;
      property Complemento: string read FComplemento write FComplemento;
      property Bairro: string read FBairro write FBairro;
      property Cidade: string read FCidade write FCidade;
      property UF: string read FUF write FUF;
      property Numero: string read FNumero write FNumero;
      property Enumerador: EnumTipoCrud read FEnumerador write FEnumerador;
      function Persistir : Boolean;
      function Listar(busca: string): TFDQuery;
      function BuscarPessoa(nCdPessoa: string): TFDQuery;

  end;

implementation

{ TVenda }

uses uDAOPessoa;

function TPessoa.BuscarPessoa(nCdPessoa: string): TFDQuery;
var
  daoPessoa : TDAOPessoa;
begin
  daoPessoa := TDAOPessoa.Create;

  result := daoPessoa.BuscarPessoa(nCdPessoa);
end;

function TPessoa.Listar(busca: string): TFDQuery;
var
  daoPessoa : TDAOPessoa;
begin
  daoPessoa := TDAOPessoa.Create;

  result := daoPessoa.Listar(busca);
end;

function TPessoa.Persistir: Boolean;
var
  daoPessoa : TDAOPessoa;
begin
  daoPessoa := TDAOPessoa.Create;

  case FEnumerador of
    Inserir:   result := daoPessoa.Inserir(Self);
    Atualizar: result := daoPessoa.Atualizar(Self);
    Excluir:   result := daoPessoa.Excluir(Self);
  end;
end;

end.
