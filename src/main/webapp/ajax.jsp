
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

<%
	String i = request.getParameter("i");
	System.out.println("i=" + i);
	String status = request.getParameter("status");
	String title = request.getParameter("hidden_title_" + i);
	String style = request.getParameter("hidden_style_" + i);
	Integer priority = Integer.parseInt(request.getParameter("hidden_priority_" + i));
	Integer chapter = Integer.parseInt(request.getParameter("chapter"));
	System.out.println("status=" + status + " title=" + title + " style=" + style + " priority=" + priority + " chapter=" + chapter);
	
	MainSvc svc = new MainSvc();
	List<Manga> mangas = svc.getMangas(status, "all", null); // get all mangas of the current category
	Manga m = new Manga(title);
	m.setStyle(style);
	m.setChapter(chapter);
	m.setPriority(priority);
	svc.changeChapterOfManga(status, mangas, m, chapter);

%>

</html>