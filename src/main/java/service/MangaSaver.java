package service;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import mvc.model.Manga;
import util.StatusUtil;

public class MangaSaver {

	public static void saveManga(Manga manga, String status) {

		String path = StatusUtil.getPathFromStatus(status);

		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(path, true));
			bw.newLine();
			bw.append(manga.getTitle() + (manga.getStyle() != null ? " | " + manga.getStyle() : "")
					+ (manga.getPriority() != null ? " | " + manga.getPriority() : "")
					+ (manga.getChapter() != null ? " | " + manga.getChapter() : ""));
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * REMARQUE : il faut passer en parametre la liste SANS le fichier à
	 * supprimer, i.e. il faut d'abord le supprimer puis passer la liste en
	 * parametre.
	 * 
	 * @param newList
	 *            : la liste des mangas dont on a deja supprimé le manga (on
	 *            utilise cette liste pour ne pas relire le fichier)
	 *
	 */
	public static void removeManga(List<Manga> newList, String title, String status) {

		String path = StatusUtil.getPathFromStatus(status);

		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(path, false));
			// on efface toutes les lignes du fichier contenant les mangas de
			// statut donné puis on y réécrit tous les mangas sauf celui de
			// titre donné
			boolean isFirstLine = true;
			for (Manga manga : newList) {
				if (!manga.getTitle().equals(title.trim())) {
					if (!isFirstLine) {
						bw.newLine();
					}
					isFirstLine = false;
					bw.append(manga.getTitle() + " | " + manga.getStyle() + " | " + manga.getPriority() + " | "
							+ manga.getChapter());
				}
			}
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public static void saveList(List<Manga> newList, String status) {

		String path = StatusUtil.getPathFromStatus(status);

		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(path, false));
			boolean isFirstLine = true;
			for (Manga manga : newList) {
				if (!isFirstLine) {
					bw.newLine();
				}
				isFirstLine = false;
				bw.append(manga.getTitle() + " | " + manga.getStyle() + " | " + manga.getPriority() + " | "
						+ manga.getChapter());

			}
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
