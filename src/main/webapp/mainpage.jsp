<%@ page import="mvc.model.*" %>
<%@ page import="service.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="mangalist/css/main.css" />
<title>Mangalist : gère tes mangas lus ou en cours !</title>
<body>

	<h1>Mangalist : gère tes mangas lus ou en cours !</h1>

	<!-- Menu : contient les boutons et liens permettant de gérer la liste des mangas, d'en ajouter, supprimer,... -->
	<section class="section_manage_mangas">
	
	<%
	MainSvc svc = new MainSvc();
	svc.loadMangas();
	%>
	
	<table>
	<tr>
		<th>Titre</th>
		<th>Genre</th>
		<th>Chapitre</th>
		<th>Priorité</th>
	</tr>
	<%
	for(Manga m : svc.getMangasInProgress()) { %>
		<tr>
			<td><%= m.getTitle() %></td>
			<td><%= m.getStyle() %></td>
			<td><%= m.getChapter() %></td>
			<td><%= m.getPriority() %></td>
		</tr>
	<% } %>
	</table>
	
	 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet dui sem. Donec dignissim sed justo et ornare. 
	 Fusce massa nulla, sollicitudin in sapien non, consectetur dictum orci. Vestibulum ante ipsum primis in faucibus orci luctus
	 et ultrices posuere cubilia Curae; Aliquam congue convallis lorem, vel ultricies nisi consequat vel. Proin molestie ipsum 
	 malesuada urna varius, venenatis fringilla orci dapibus. Nam tincidunt metus vitae urna posuere vestibulum. Nam auctor lectus
	 a hendrerit laoreet. Nam sagittis et ante a ultricies. Donec ultrices blandit finibus.</p>

	<p>Maecenas placerat varius blandit. Nam posuere sodales risus id ullamcorper. Proin ut pulvinar nisl, in hendrerit arcu.
	 Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis
	  in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse malesuada consequat ipsum a euismod. Aliquam non lorem vitae leo semper blandit.</p>

	<p>Duis et massa quis ex condimentum luctus. Aliquam finibus lectus non nisi ultrices, vitae interdum sapien sodales. Proin auctor lorem a venenatis
	 hendrerit. Duis nec diam et dolor faucibus sagittis vel in massa. Integer et felis eu nisi pulvinar malesuada vel a erat. Integer lobortis, nibh 
	 eu commodo faucibus, enim neque pharetra sem, ullamcorper volutpat erat massa sed urna. Cras a malesuada orci.</p>

	<p>Nulla ut mollis risus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In a viverra nisl.
	 Nam fringilla sapien id sapien rutrum pretium. Praesent a cursus sapien. Nunc id ultrices tellus. Maecenas feugiat neque non mattis mattis.
	  Donec feugiat nisi ut placerat dictum. Suspendisse potenti. Donec at lacus et magna maximus blandit. Duis eget arcu vel leo congue pulvinar ac eget elit.
	   Nulla cursus dolor id metus pretium posuere. Pellentesque sit amet imperdiet tortor. Donec consequat imperdiet gravida. Nulla massa erat, aliquet id 
	   tempor non, dignissim id ligula. Maecenas vel leo sodales, tempus risus id, volutpat tortor.</p>
	
	</section>

	<!-- Section principale de la page. Affiche les mangas de la catgéorie souhaitée (finis, en cours...) -->
	<section class="section_display_mangas">
	
	<p>Duis et massa quis ex condimentum luctus. Aliquam finibus lectus non nisi ultrices, vitae interdum sapien sodales. Proin auctor lorem a venenatis
	 hendrerit. Duis nec diam et dolor faucibus sagittis vel in massa. Integer et felis eu nisi pulvinar malesuada vel a erat. Integer lobortis, nibh 
	 eu commodo faucibus, enim neque pharetra sem, ullamcorper volutpat erat massa sed urna. Cras a malesuada orci.</p>

	<p>Nulla ut mollis risus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In a viverra nisl.
	 Nam fringilla sapien id sapien rutrum pretium. Praesent a cursus sapien. Nunc id ultrices tellus. Maecenas feugiat neque non mattis mattis.
	  Donec feugiat nisi ut placerat dictum. Suspendisse potenti. Donec at lacus et magna maximus blandit. Duis eget arcu vel leo congue pulvinar ac eget elit.
	   Nulla cursus dolor id metus pretium posuere. Pellentesque sit amet imperdiet tortor. Donec consequat imperdiet gravida. Nulla massa erat, aliquet id 
	   tempor non, dignissim id ligula. Maecenas vel leo sodales, tempus risus id, volutpat tortor.</p>
	
	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet dui sem. Donec dignissim sed justo et ornare. 
	 Fusce massa nulla, sollicitudin in sapien non, consectetur dictum orci. Vestibulum ante ipsum primis in faucibus orci luctus
	 et ultrices posuere cubilia Curae; Aliquam congue convallis lorem, vel ultricies nisi consequat vel. Proin molestie ipsum 
	 malesuada urna varius, venenatis fringilla orci dapibus. Nam tincidunt metus vitae urna posuere vestibulum. Nam auctor lectus
	 a hendrerit laoreet. Nam sagittis et ante a ultricies. Donec ultrices blandit finibus.</p>

	<p>Maecenas placerat varius blandit. Nam posuere sodales risus id ullamcorper. Proin ut pulvinar nisl, in hendrerit arcu.
	 Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis
	  in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse malesuada consequat ipsum a euismod. Aliquam non lorem vitae leo semper blandit.</p>
	
	</section>

</body>
</html>