
<%@ page import="mvc.model.*" %>
<%@ page import="service.*" %>

<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/main.css" />
<title>Mangalist : g�re tes mangas lus ou en cours !</title>
<body>

	<h1>Mangalist : g�re tes mangas lus ou en cours !</h1>

	<!-- Section principale de la page. Affiche les mangas de la catg�orie souhait�e (finis, en cours...) -->
	<section class="section_display_mangas">
	
	<%
	String status = request.getParameter("status");
	if(status == null) {
		status = "to_read";
	}
	System.out.println("statut actuel : " + status);
	MainSvc svc = new MainSvc();
	svc.loadMangas();
	List<Manga> mangasInCurrentStatus = svc.getMangas(status);
	%>
	
	<table>
	<tr>
		<th>Titre</th>
		<th>Genre</th>
		<th>Chapitre</th>
		<th>Priorit�</th>
	</tr>
	<%
	for(Manga m : mangasInCurrentStatus) { %>
		<tr>
			<td><%= m.getTitle() %></td>
			<td><%= m.getStyle() %></td>
			<td><%= m.getChapter() %></td>
			<td><%= m.getPriority() %></td>
		</tr>
	<% } %>
	</table>
	
	</section>
	
	<!-- Menu : contient les boutons et liens permettant de g�rer la liste des mangas, d'en ajouter, supprimer,... -->
	<section class="section_manage_mangas">
	
	<p>
		Cette section te permet de g�rer tes mangas. Tu peux :
	</p>
	<ul>
		<li>Changer de cat�gorie pour voir uniquement tes mangas temrin�s, en cours de lecture ou bien � commencer</li>
		<li>Filtrer selon le style pour n'afficher que les mangas d'un style particulier</li>
		<li>Ajouter / Supprimer un manga</li>
		<li>Rechercher un manga</li>
		<li>Modifier les informations d'un manga</li>
		<li>D�placer un manga d'une cat�gorie � une autre</li>
	</ul>

	<p>
		Cat�gorie :
	</p>
	<form action="mainpage.jsp" method="post">
	
		<select onchange="window.location.href='mainpage.jsp?status=' + this.value">
			<option value="to_read" <%if(status.equals("to_read")){%> selected="selected" <%}%> >A lire</option>
			<option value="in_progress" <%if(status.equals("in_progress")){%> selected="selected" <%}%> >En cours de lecture</option>
			<option value="finished" <%if(status.equals("finished")){%> selected="selected" <%}%> >Termin�s</option>
		</select>
	
	</form>
	
	<p>zzzzzzzzzzzzzzzzzzzzzzz</p>
	<p>zzzzzzzzzzzzzzzzzzzzzzz</p>

	
	</section>

</body>
</html>