<%@page import="br.ufac.academico.entity.Curso"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cll" scope="page" class="br.ufac.academico.logic.CurriculoLogic" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CursoLogic" />
<jsp:useBean id="curso" scope="page" class="br.ufac.academico.entity.Curso" />
<jsp:useBean id="c" scope="page" class="br.ufac.academico.entity.Curriculo" />
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acad�mico</title>
</head>
<body>

<%
	if(!cnx.estaConectado()){
%>
<jsp:forward page="index.jsp" />
<%
	}
%>
 
<%
	if(request.getParameter("cancelar") != null){
%>
<jsp:forward page="curriculoListar.jsp" />
<%
	}
%>

<%
	//PESSOAL, FALTOU LIGAR pl A cnx;
	cll.setConexao(cnx);
	cl.setConexao(cnx);
	

	if(request.getParameter("confirmar") != null){
		long codigo = Long.parseLong(request.getParameter("codigo")); 
		cll.remover(codigo);
		
%>
<jsp:forward page="curriculoListar.jsp" />
<%
	}
%>
<%
	List<Curso> cursos = cl.recuperarTodosPorNome();

	if(request.getParameter("codigo") != null &&
		request.getParameter("curso") == null &&
		request.getParameter("descricao") == null)
	{
		long codigo = Long.parseLong(request.getParameter("codigo")); 
		c = cll.recuperar(codigo);
	}

%>
<h1>Sistema de Controle Acad�mico</h1>
<h2>Edi��o de Curriculo</h2>
<form action="curriculoExcluir.jsp" method="post">
<p>
	C�digo: <input type="text" name="codigo" value="<%= c.getCodigo() %>" readonly="readonly" /> <br/>
	Descri��o: <input type="text" name="descricao" value="<%= c.getDescricao() %>" /> <br/>
	Curso: <select name="curso">
<%
	for(Curso cu : cursos){
%>
		<option value="<%= c.getCodigo()%>" <%= (c.getCodigo()==c.getCurso().getCodigo())?"selected":"" %> >
			<%= cu.getNome()%>
		</option>
<%
	}
%>			
	</select>
	
</p>
<p>	
	<input type="submit" name="confirmar" value="Confirmar" />	
	<input type="submit" name="cancelar" value="Cancelar" />
</p>
</form>
</body>
</html>