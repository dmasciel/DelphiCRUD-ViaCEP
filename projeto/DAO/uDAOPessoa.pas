unit uDAOPessoa;

interface

uses uControllerConection,Data.Win.ADODB,System.SysUtils,uPessoa,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDAOPessoa = class
    private
       ModeloPessoa : TPessoa;

    public
      function Inserir(ModeloPessoa : TPessoa): Boolean;
      function Atualizar(ModeloPessoa : TPessoa): Boolean;
      function Excluir(ModeloPessoa : TPessoa): Boolean;
      function Listar(busca: string): TFDQuery;
      function BuscarPessoa(nCdPessoa: string): TFDQuery;
  end;
implementation

{ TDAOVenda }

function TDAOPessoa.Atualizar(ModeloPessoa : TPessoa): Boolean;
var
  Query : TFDQuery;
begin
  try

    try
      Query := TControllerConection.getInstance().daoConection.CriarQuery;
      Query.SQL.Add('UPDATE Pessoa SET cNome = :Nome,cRG = :RG,dDataNascimento = :DataNascimento ,nCEP = :CEP,cLogradouro = :Logradouro, cComplemento = :Complemento,cBairro = :Bairro,cCidade = :Cidade,cUF = :UF,cNumero = :Numero ');
      Query.SQL.Add('WHERE nCdPessoa = :nCdPessoa');

      Query.Params.ParamByName('nCdPessoa').Value      := ModeloPessoa.Codigo;
      Query.Params.ParamByName('Nome').Value           := ModeloPessoa.Nome;
      Query.Params.ParamByName('RG').Value             := ModeloPessoa.RG;
      Query.Params.ParamByName('DataNascimento').Value := ModeloPessoa.DataNascimento;
      Query.Params.ParamByName('CEP').Value            := ModeloPessoa.CEP;
      Query.Params.ParamByName('Logradouro').Value     := ModeloPessoa.Logradouro;
      Query.Params.ParamByName('Complemento').Value    := ModeloPessoa.Complemento;
      Query.Params.ParamByName('Bairro').Value         := ModeloPessoa.Bairro;
      Query.Params.ParamByName('Cidade').Value         := ModeloPessoa.Cidade;
      Query.Params.ParamByName('UF').Value             := ModeloPessoa.UF;
      Query.Params.ParamByName('numero').Value         := ModeloPessoa.Numero;


      //Executa a query
      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;
    Result := True;
  except
    Result := False;
  end;

end;

function TDAOPessoa.Excluir(ModeloPessoa : TPessoa): Boolean;
var
  Query : TFDQuery;
begin
  try
    try
      Query := TControllerConection.getInstance().daoConection.CriarQuery;
      Query.SQL.Add('DELETE FROM Pessoa');
      Query.SQL.Add('WHERE nCdPessoa = :nCdPessoa');
      //Passa por parametro os valores por ser mais seguro
      Query.Params.ParamByName('nCdPessoa').Value := ModeloPessoa.Codigo;

      //Executa a query
      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;
    Result := True;
  except
    Result := False;
  end;

end;

function TDAOPessoa.Inserir(ModeloPessoa : TPessoa): Boolean;
var
  Query : TFDQuery;
begin
  try
    try
      Query := TControllerConection.getInstance().daoConection.CriarQuery;
      Query.SQL.Add('INSERT INTO Pessoa (cNome,cRG,dDataNascimento,nCEP,cLogradouro,cComplemento,cBairro,cCidade,cUF,cNumero)' );
      Query.SQL.Add('           VALUES (:Nome,:RG,:DataNascimento,:CEP,:Logradouro,:Complemento,:Bairro,:Cidade,:UF,:Numero)');
      //Passa por parametro os valores por ser mais seguro

      Query.Params.ParamByName('Nome').Value := ModeloPessoa.Nome;
      Query.Params.ParamByName('RG').Value := ModeloPessoa.RG;
      Query.Params.ParamByName('DataNascimento').Value := ModeloPessoa.DataNascimento;
      Query.Params.ParamByName('CEP').Value := ModeloPessoa.CEP;
      Query.Params.ParamByName('Logradouro').Value := ModeloPessoa.Logradouro;
      Query.Params.ParamByName('Complemento').Value := ModeloPessoa.Complemento;
      Query.Params.ParamByName('Bairro').Value := ModeloPessoa.Bairro;
      Query.Params.ParamByName('Cidade').Value := ModeloPessoa.Cidade;
      Query.Params.ParamByName('UF').Value := ModeloPessoa.UF;
      Query.Params.ParamByName('Numero').Value := ModeloPessoa.Numero;
      //Executa a query
      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;
    Result := True;
  except
    Result := False;
  end;

end;

function TDAOPessoa.Listar(busca: string): TFDQuery;
var
  Query : TFDQuery;
begin
  Query := TControllerConection.getInstance().daoConection.CriarQuery;
  Query.Close;
  Query.SQL.Add('select * from Pessoa');
  if busca <> '' then
    Query.SQL.Add('where cNome like ' +  chr(39) + '%' + busca + '%' + chr(39));

  Query.Open;
  Result := Query;
end;


function TDAOPessoa.BuscarPessoa(nCdPessoa: string): TFDQuery;
var
  Query : TFDQuery;
begin
  Query := TControllerConection.getInstance().daoConection.CriarQuery;
  Query.Close;
  Query.SQL.Add('select * from Pessoa');
  Query.SQL.Add('where nCdPessoa = ' + nCdPessoa);

  Query.Open;
  Result := Query;
end;

end.
