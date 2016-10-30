package service;

import java.util.List;

import mvc.model.Manga;

/**
 * Main service of the application. Called in the main page (mainpage.jsp) to
 * initialize the manga list (loading from a file)
 */
public class MainSvc {

	public List<Manga> getMangas(String status, String style, Integer priority) {

		return MangaLister.getMangas(status, style, priority);

	}

	public void addManga(String status, String title, String style, Integer priority) {

		Manga manga = new Manga(title);
		manga.setStyle(style);
		manga.setPriority(priority);

		MangaSaver.saveManga(manga, status);

	}

}
