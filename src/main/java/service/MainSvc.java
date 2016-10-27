package service;

import java.util.List;

import mvc.model.Manga;

/**
 * Main service of the application. Called in the main page (mainpage.jsp) to
 * initialize the manga list (loading from a file)
 */
public class MainSvc {

	private List<Manga> mangasToRead;
	private List<Manga> mangasInProgress;
	private List<Manga> mangasFinished;

	public void loadMangas() {

		mangasToRead = MangaLister.getMangas("TO_READ");
		mangasInProgress = MangaLister.getMangas("IN_PROGRESS");
		mangasFinished = MangaLister.getMangas("FINISHED");

	}

	public List<Manga> getMangasToRead() {
		return mangasToRead;
	}

	public void setMangasToRead(List<Manga> mangasToRead) {
		this.mangasToRead = mangasToRead;
	}

	public List<Manga> getMangasInProgress() {
		return mangasInProgress;
	}

	public void setMangasInProgress(List<Manga> mangasInProgress) {
		this.mangasInProgress = mangasInProgress;
	}

	public List<Manga> getMangasFinished() {
		return mangasFinished;
	}

	public void setMangasFinished(List<Manga> mangasFinished) {
		this.mangasFinished = mangasFinished;
	}

}
