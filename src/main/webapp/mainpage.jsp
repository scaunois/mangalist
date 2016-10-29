
<%@ page import="mvc.model.*"%>
<%@ page import="service.*"%>

<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	// Get parameters from the url
	
	String status = request.getParameter("status");
	String style = request.getParameter("style");
	String priority_str = request.getParameter("priority_str");
	Integer priority = null;
	
	// Define default values
	
	if(status == null) {
		status = "in_progress";
	}

	if(style == null) {
		style = "all";
	}
	
	if (priority_str != null && !priority_str.equals("all")) {
		try {
	priority = Integer.parseInt(priority_str);
		} catch(NumberFormatException e) {
	// 'priority' will keep its null value
		}
	}
	
	MainSvc svc = new MainSvc();
	List<Manga> mangasInCurrentStatus = svc.getMangas(status, style, priority);
%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/mangalist/css/main.css" />
<title>Mangalist : g�re tes mangas lus ou en cours !</title>
<body>

	<h1>Mangalist : g�re tes mangas lus ou en cours !</h1>

	<!--  Main section of the page. Display mangas of the selected category (status)(finished, in progress,...) -->
	<div class="section_display_mangas">

		<table>
			<tr>
				<th>Titre</th>
				<th>Genre</th>
				<th>Chapitre</th>
				<th>Priorit�</th>
			</tr>
			<%
				for(Manga m : mangasInCurrentStatus) {
			%>
			<tr>
				<td><%=m.getTitle()%></td>
				<td><%=m.getStyle()%></td>
				<td><%=m.getChapter()%></td>
				<td><%=m.getPriority()%></td>
			</tr>
			<%
				}
			%>
		</table>

	</div>

	<!-- Management section : contains controls to manage the list of mangas, to add/remove a manga,... -->
	<div class="section_manage_mangas">

		<!--
	<p>
		Cette section te permet de g�rer tes mangas. Tu peux :
	</p>
	<ul>
		<li>Changer de cat�gorie pour voir uniquement tes mangas termin�s, en cours de lecture ou bien � commencer</li>
		<li>Filtrer selon le style pour n'afficher que les mangas d'un style particulier</li>
		<li>Ajouter / Supprimer un manga</li>
		<li>Rechercher un manga</li>
		<li>Modifier les informations d'un manga</li>
		<li>D�placer un manga d'une cat�gorie � une autre</li>
	</ul>
	-->

		<div class="section_filters">

			<h2>Filtres</h2>

			<p>
				<label for="select_status">Cat�gorie :</label> <select
					id="select_status" onchange="reloadPage();">
					<option value="to_read" <%if(status.equals("to_read")){%>
						selected="selected" <%}%>>A lire</option>
					<option value="in_progress" <%if(status.equals("in_progress")){%>
						selected="selected" <%}%>>En cours de lecture</option>
					<option value="finished" <%if(status.equals("finished")){%>
						selected="selected" <%}%>>Termin�s</option>
				</select>
			</p>

			<p>
				<label for="select_style">Filtrer par style :</label> <select
					id="select_style" onchange="reloadPage();">
					<option value="all" <%if(style.equals("all")){%>
						selected="selected" <%}%>>Tous les styles</option>
					<option value="josei" <%if(style.equals("josei")){%>
						selected="selected" <%}%>>JOSEI</option>
					<option value="smut" <%if(style.equals("smut")){%>
						selected="selected" <%}%>>SMUT</option>
					<option value="yaoi" <%if(style.equals("yaoi")){%>
						selected="selected" <%}%>>YAOI</option>
					<option value="others" <%if(style.equals("others")){%>
						selected="selected" <%}%>>Autres</option>
				</select>
			</p>

			<p>
				<label for="select_priority">Filtrer par priorit� :</label> <select
					id="select_priority" onchange="reloadPage();">
					<option value="all" <%if(priority == null){%> selected="selected"
						<%}%>>Toutes les priorit�s</option>
					<option value="0" <%if(priority != null && priority.equals(0)){%>
						selected="selected" <%}%>>0</option>
					<option value="1" <%if(priority != null && priority.equals(1)){%>
						selected="selected" <%}%>>1</option>
					<option value="2" <%if(priority != null && priority.equals(2)){%>
						selected="selected" <%}%>>2</option>
					<option value="3" <%if(priority != null && priority.equals(3)){%>
						selected="selected" <%}%>>3</option>
					<option value="4" <%if(priority != null && priority.equals(4)){%>
						selected="selected" <%}%>>4</option>
					<option value="5" <%if(priority != null && priority.equals(5)){%>
						selected="selected" <%}%>>5</option>
					<option value="6" <%if(priority != null && priority.equals(6)){%>
						selected="selected" <%}%>>6</option>
					<option value="7" <%if(priority != null && priority.equals(7)){%>
						selected="selected" <%}%>>7</option>
					<option value="8" <%if(priority != null && priority.equals(8)){%>
						selected="selected" <%}%>>8</option>
					<option value="9" <%if(priority != null && priority.equals(9)){%>
						selected="selected" <%}%>>9</option>
					<option value="10" <%if(priority != null && priority.equals(10)){%>
						selected="selected" <%}%>>10</option>
				</select>
			</p>

		</div>

		<div class="section_add">

			<h2>Ajouter un manga</h2>
			
			<form>
				<label for="add_title">Titre (<strong>obligatoire</strong>) :</label>
				<input type="text" id="add_title" size="30"> <br/>
				<label for="add_style">Style :</label>
				<select id="add_style">
					<option value="">Choisir une valeur</option>
					<option value="josei">JOSEI</option>
					<option value="smut">SMUT</option>
					<option value="yaoi">YAOI</option>
					<option value="others">Autres</option>
				</select> <br/>
				<label for="add_priority">Priorit� :</label>
				<select id="add_priority">
					<option value="">Choisir une valeur</option>
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</form>

		</div>
		
		<div class="section_remove">

			<h2>Supprimer un manga</h2>

		</div>
		
		<div class="section_search">

			<h2>Recherche</h2>

		</div>


	</div>

	<script>
		function reloadPage() {

			var url = 'mainpage.jsp?';
			url += 'status=' + document.getElementById('select_status').value;
			url += '&style=' + document.getElementById('select_style').value;
			url += '&priority_str='
					+ document.getElementById('select_priority').value;

			//alert('appel page ' + url);

			window.location.href = url;

		}
	</script>

</body>
</html>