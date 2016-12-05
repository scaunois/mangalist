package service;

import java.util.Arrays;
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

		addManga(status, title, style, null, priority);

	}

	public void addManga(String status, String title, String style, Integer chapter, Integer priority) {

		Manga manga = new Manga(title);
		manga.setStyle(style);
		manga.setChapter(chapter);
		manga.setPriority(priority);

		MangaSaver.saveManga(manga, status);

	}

	public void removeManga(String status, List<Manga> mangas, String title) {

		Manga mangaToRemove = null;
		for (Manga manga : mangas) {
			if (manga.getTitle().equalsIgnoreCase(title.trim())) {
				mangaToRemove = manga;
			}
		}
		mangas.remove(mangaToRemove);

		MangaSaver.saveList(mangas, status);

	}

	public String searchManga(String title) {

		// if the manga is found, returns the status in which it was found, else
		// returns "not_found"
		String res = "not_found";

		List<Manga> mangasToRead = getMangas("to_read", "all", null);
		List<Manga> mangasInProgress = getMangas("in_progress", "all", null);
		List<Manga> mangasFinished = getMangas("finished", "all", null);

		for (Manga m : mangasToRead) {
			if (m.getTitle().equalsIgnoreCase(title.trim())) {
				res = "to_read";
			}
		}

		for (Manga m : mangasInProgress) {
			if (m.getTitle().equalsIgnoreCase(title.trim())) {
				res = "in_progress";
			}
		}

		for (Manga m : mangasFinished) {
			if (m.getTitle().equalsIgnoreCase(title.trim())) {
				res = "finished";
			}
		}

		return res;

	}

	public void changeStatusOfManga(List<Manga> mangas, Manga m, String old_status, String new_status) {

		removeManga(old_status, mangas, m.getTitle());
		MangaSaver.saveManga(m, new_status);

	}

	public void changeChapterOfManga(String status, List<Manga> mangas, Manga m, Integer new_chapter) {

		System.out.println("status=" + status);
		System.out.println("mangas :\n" + Arrays.toString(mangas.toArray()));
		System.out.println("manga : " + m.toString2());
		System.out.println("new_chapter=" + new_chapter);

		removeManga(status, mangas, m.getTitle());
		addManga(status, m.getTitle(), m.getStyle(), m.getChapter(), m.getPriority());

	}

}
