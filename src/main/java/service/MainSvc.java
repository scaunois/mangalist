package service;

import java.util.List;

import mvc.model.Manga;

/**
 * Main service of the application. Called in the main page (mainpage.jsp) to
 * initialize the manga list (loading from a file)
 */
public class MainSvc {

	private List<Manga> mangas;

	private final String mangas_to_read = "";
	private final String mangas_in_progress = "";
	private final String mangas_finished = "";

	public void loadMangas() {

	}

}
