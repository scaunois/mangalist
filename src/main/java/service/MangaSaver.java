package service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import mvc.model.Manga;
import util.StatusUtil;

public class MangaSaver {

	public static void saveManga(Manga manga, String status) {

		String path = StatusUtil.getPathFromStatus(status);

		try {
			File f = new File(path);
			BufferedReader br = new BufferedReader(new FileReader(f));
			BufferedWriter bw = new BufferedWriter(new FileWriter(f, true));
			boolean fileIsEmpty = (br.readLine() == null);
			if (!fileIsEmpty) {
				bw.newLine();
			}
			bw.append(manga.getTitle() + (manga.getStyle() != null ? " | " + manga.getStyle() : "")
					+ (manga.getPriority() != null ? " | " + manga.getPriority() : "")
					+ (manga.getChapter() != null ? " | " + manga.getChapter() : ""));
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * REMARQUE : il faut passer en parametre la liste SANS le fichier �
	 * supprimer, i.e. il faut d'abord le supprimer puis passer la liste en
	 * parametre.
	 * 
	 * @param newList
	 *            : la liste des mangas dont on a deja supprim� le manga (on
	 *            utilise cette liste pour ne pas relire le fichier)
	 *
	 */
	public static void removeManga(List<Manga> newList, String title, String status) {

		String path = StatusUtil.getPathFromStatus(status);

		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(path, false));
			// on efface toutes les lignes du fichier contenant les mangas de
			// statut donn� puis on y r��crit tous les mangas sauf celui de
			// titre donn�
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
