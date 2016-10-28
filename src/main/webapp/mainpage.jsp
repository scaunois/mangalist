
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
<title>Mangalist : gère tes mangas lus ou en cours !</title>
<body>

	<h1>Mangalist : gère tes mangas lus ou en cours !</h1>

	<!-- Section principale de la page. Affiche les mangas de la catgéorie souhaitée (finis, en cours...) -->
	<section class="section_display_mangas">
	
	<%
	
	// Chargement des paramètres de la requête (url)
	
	String status = request.getParameter("status");
	String style = request.getParameter("style");
	
	if(status == null) {
		status = "to_read";
	}
	
	if(style == null) {
		style = "all";
	}
	
	MainSvc svc = new MainSvc();
	svc.loadMangas();
	List<Manga> mangasInCurrentStatus = svc.getMangas(status);
	
	%>
	
	<table>
	<tr>
		<th>Titre</th>
		<th>Genre</th>
		<th>Chapitre</th>
		<th>Priorité</th>
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
	
	<!-- Menu : contient les boutons et liens permettant de gérer la liste des mangas, d'en ajouter, supprimer,... -->
	<section class="section_manage_mangas">
	
	<p>
		Cette section te permet de gérer tes mangas. Tu peux :
	</p>
	<ul>
		<li>Changer de catégorie pour voir uniquement tes mangas terminés, en cours de lecture ou bien à commencer</li>
		<li>Filtrer selon le style pour n'afficher que les mangas d'un style particulier</li>
		<li>Ajouter / Supprimer un manga</li>
		<li>Rechercher un manga</li>
		<li>Modifier les informations d'un manga</li>
		<li>Déplacer un manga d'une catégorie à une autre</li>
	</ul>

	<p>
		Catégorie :
	</p>	
	<p>
		<select id="select_status" onchange="reloadMainPage();">
			<option value="to_read" <%if(status.equals("to_read")){%> selected="selected" <%}%> >A lire</option>
			<option value="in_progress" <%if(status.equals("in_progress")){%> selected="selected" <%}%> >En cours de lecture</option>
			<option value="finished" <%if(status.equals("finished")){%> selected="selected" <%}%> >Terminés</option>
		</select>
	</p>
	
	<p>
		Filtrer par style (remarque : 'Tous les styles' affichera les mangas de n'importe quel style, tandis que 'Autres' affichera tous les mangas hors Josei/Smut/Yaoi) :
	</p>
	<p>
		<select id="select_style" onchange="reloadMainPage();">		
			<option value="all" <%if(style.equals("all")){%> selected="selected" <%}%> >Tous les styles</option>
			<option value="josei" <%if(style.equals("josei")){%> selected="selected" <%}%> >JOSEI</option>
			<option value="smut" <%if(style.equals("smut")){%> selected="selected" <%}%> >SMUT</option>
			<option value="yaoi" <%if(style.equals("yaoi")){%> selected="selected" <%}%> >YAOI</option>
			<option value="others" <%if(style.equals("others")){%> selected="selected" <%}%> >Autres</option>
		</select>
	</p>
	
	<p>zzzzzzzzzzzzzzzzzzzzzzz</p>
	<p>zzzzzzzzzzzzzzzzzzzzzzz</p>

	
	</section>

	<script>
	
	function reloadMainPage() {

		var url = 'mainpage.jsp?';
		url += 'status=' + document.getElementById('select_status').value;
		url += '&style=' + document.getElementById('select_style').value;

		alert('appel page ' + url);
		
		window.location.href = url;
		
	}
		
	</script>

</body>
</html>