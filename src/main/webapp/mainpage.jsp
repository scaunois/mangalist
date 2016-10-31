
<%@ page import="mvc.model.*"%>
<%@ page import="service.*"%>

<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/mangalist/css/main.css" />
<title>Mangalist : gère tes mangas lus ou en cours !</title>
<body>

<%
	// Get parameters from the url

	String status = request.getParameter("status");
	String style = request.getParameter("style");
	String priority_str = request.getParameter("priority_str");
	Integer priority = null;

	// Define default values

	if (status == null) {
		status = "in_progress";
	}

	if (style == null) {
		style = "all";
	}

	if (priority_str != null && !priority_str.equals("all")) {
		try {
			priority = Integer.parseInt(priority_str);
		} catch (NumberFormatException e) {
			// 'priority' will keep its null value
		}
	}

	System.out.println("status=" + status + " style=" + style + " priority=" + priority);

	MainSvc svc = new MainSvc();
	List<Manga> mangas = svc.getMangas(status, style, priority);

	// if necessary (request = POST), add, remove or edit the manga

	// adds a manga

	if (request.getParameter("add_submit") != null) {

		String add_title = request.getParameter("add_title");
		String add_style = request.getParameter("add_style");
		Integer add_priority = null;
		try {
			add_priority = Integer.parseInt(request.getParameter("add_priority"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		String add_status = request.getParameter("add_status");
		System.out.println("requete d'ajout : title=" + add_title + " style=" + add_style + " priority="
				+ add_priority + " status=" + add_status);
		if (!add_title.equals("") && !MangaLister.alreadyExists(mangas, add_title)) {
			svc.addManga(add_status, add_title, add_style, add_priority);
		}
		response.sendRedirect("mainpage.jsp"); // reload the page to view changes
	}

	// removes a manga	

	if (request.getParameter("remove_submit") != null) {

		String remove_title = request.getParameter("remove_title");
		svc.removeManga(status, mangas, remove_title);
		response.sendRedirect("mainpage.jsp");

	}

	// search a manga

	String search_title = null;
	String search_result = null;
	if (request.getParameter("search_submit") != null) {

		search_title = request.getParameter("search_title");
		search_result = svc.searchManga(search_title);
		System.out.println("vérification existence du manga [" + search_title + "] : [" + search_result + "]");

	}
	
	// controls if a button to change the status of a manga should be present or not
	boolean button_move_to_in_progress = false;
	boolean button_move_to_finished = false;
	
	if(status.equals("to_read")) {
		button_move_to_in_progress = true;
		button_move_to_finished = true;
	}
	if(status.equals("in_progress")) {
		button_move_to_finished = true;
	}
	
	// change the status of a manga
	String move_title = request.getParameter("move_title"); 
	if(move_title != null) {
		String move_style = request.getParameter("move_style");
		String move_priority = request.getParameter("move_priority");
		String move_chapter = request.getParameter("move_chapter");
		String new_status = request.getParameter("new_status");
		System.out.println("move_title=" + move_title + " new_status=" + new_status);
		Manga m = new Manga(move_title);
		m.setStyle(move_style);
		m.setPriority(Integer.parseInt(move_priority));
		m.setChapter(Integer.parseInt(move_chapter));
		svc.changeStatusOfManga(mangas, m, status, new_status);
		response.sendRedirect("mainpage.jsp");
	}
	
%>

	<h1>Mangalist : gère tes mangas lus ou en cours !</h1>

	<!--  Main section of the page. Display mangas of the selected category (status)(finished, in progress,...) -->
	<div class="section_display_mangas">
	
		<form action='mainpage.jsp' method='post'>

		<table>
			<tr>
				<th>Titre</th>
				<th>Genre</th>
				<th>Chapitre</th>
				<th>Priorité</th>
<!-- 				<th>Marquer comme terminé</th> -->
<!-- 				<th>Marquer comme commencé</th> -->
			</tr>
			<%
				for(Manga m : mangas) {
			%>
			<tr>
				<td><%=m.getTitle()%></td>
				<td><%=m.getStyle().replace("others", "Autres")%></td>
				<td><%=m.getChapter()%></td>
				<td><%=m.getPriority()%></td>
				<% if(button_move_to_finished == true) { %> <td><a href="mainpage.jsp?status=<%=status%>&style=<%=style%>&move_title=<%=m.getTitle()%>&move_style=<%=m.getStyle()%>&move_priority=<%=m.getPriority()%>&move_chapter=<%=m.getChapter()%>&new_status=finished" >Marquer comme terminé</a></td> <% } %>
				<% if(button_move_to_in_progress == true) { %> <td><a href="mainpage.jsp?status=<%=status%>&style=<%=style%>&move_title=<%=m.getTitle()%>&move_style=<%=m.getStyle()%>&move_priority=<%=m.getPriority()%>&move_chapter=<%=m.getChapter()%>&new_status=in_progress" >Marquer comme commencé</a></td> <% } %>
			</tr>
			<%
				}
			%>
		</table>
		
		</form>

	</div>

	<!-- Management section : contains controls to manage the list of mangas, to add/remove a manga,... -->
	<div class="section_manage_mangas">

		<!--
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
	-->

		<div class="section_filters">

			<h2>Filtres</h2>

			<p>
				<label for="select_status">Catégorie :</label> <select
					id="select_status" name="status" onchange="reloadPage();">
					<option value="to_read" <%if(status.equals("to_read")){%>
						selected="selected" <%}%>>A lire</option>
					<option value="in_progress" <%if(status.equals("in_progress")){%>
						selected="selected" <%}%>>En cours de lecture</option>
					<option value="finished" <%if(status.equals("finished")){%>
						selected="selected" <%}%>>Terminés</option>
				</select>
			</p>

			<p>
				<label for="select_style">Filtrer par style :</label> <select
					id="select_style" name="style" onchange="reloadPage();">
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
				<label for="select_priority">Filtrer par priorité :</label> <select
					id="select_priority" name="priority" onchange="reloadPage();">
					<option value="all" <%if(priority == null){%> selected="selected"
						<%}%>>Toutes les priorités</option>
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

			<form action="mainpage.jsp" method="post">
				<p>
					<label for="add_title">Titre (<strong>obligatoire</strong>)
						:
					</label> <input type="text" id="add_title" name="add_title" size="30" />
				</p>
				<p>
					<label for="add_style">Style :</label> <select id="add_style"
						name="add_style">
						<option value="others" <%if(style.equals("others")){%>
							selected="selected" <%}%>>Autres</option>
						<option value="josei" <%if(style.equals("josei")){%>
							selected="selected" <%}%>>JOSEI</option>
						<option value="smut" <%if(style.equals("smut")){%>
							selected="selected" <%}%>>SMUT</option>
						<option value="yaoi" <%if(style.equals("yaoi")){%>
							selected="selected" <%}%>>YAOI</option>
					</select>
				</p>
				<p>
					<label for="add_priority">Priorité :</label> <select
						id="add_priority" name="add_priority">
						<option value="0" selected="selected">0</option>
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
				</p>
				<p>
					<label for="add_status">Catégorie</label> <select id="add_status"
						name="add_status">
						<option value="to_read" <%if(status.equals("to_read")){%>
							selected="selected" <%}%>>A lire</option>
						<option value="in_progress" <%if(status.equals("in_progress")){%>
							selected="selected" <%}%>>En cours de lecture</option>
						<option value="finished" <%if(status.equals("finished")){%>
							selected="selected" <%}%>>Terminés</option>
					</select>
				</p>
				<p>
					<input name="add_submit" type="submit" value="Ajouter le manga" />
				</p>
				<input name="status" type="hidden" value="<%=status%>"> <input
					name="style" type="hidden" value="<%=style%>"> <input
					name="priority" type="hidden" value="<%=priority%>">
			</form>

		</div>

		<div class="section_remove">

			<h2>Supprimer un manga</h2>

			<form action="mainpage.jsp" method="post">
				<p>
					<label for="remove_title">Titre :</label> <input id="remove_title"
						name="remove_title" type="text" size="30" />
				</p>
				<p>
					<input name="remove_submit" type="submit"
						value="Supprimer le manga" />
				</p>
			</form>

		</div>

		<div class="section_search">

			<h2>Recherche</h2>

			<form action="mainpage.jsp" method="post">
				<p>
					<label for="search_title">Titre :</label> <input id="search_title"
						name="search_title" type="text" size="30" />
				</p>
				<p>
					<input name="search_submit" type="submit"
						value="Chercher" />
				</p>
			</form>

		</div>


	</div>
	
	<% 
	if (request.getParameter("search_submit") != null) {
		
		System.out.println("ici");
		
		if(!search_result.equals("not_found")) {
			String search_result_FRENCH = null;
			if(search_result.equals("to_read")) {
				search_result_FRENCH = "A lire";
			} else if(search_result.equals("in_progress")) {
				search_result_FRENCH = "En cours de lecture";
			} else if(search_result.equals("finished")) {
				search_result_FRENCH = "Terminés";
			}
			System.out.println("ici 2");
			%>
			<script>alert("Le manga [<%= search_title.trim() %>] a été trouvé dans la catégorie : <%= search_result_FRENCH %>");</script>
	<% 
		} else { %>
			<script>alert("Le manga [<%= search_title %>] n'existe pas. Tu peux le créer ! ^_^");</script>
	<%
		}
		
	}
	%>

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