package service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import mvc.model.Manga;
import util.StatusUtil;

public class MangaLister {

	public static List<Manga> getMangas(String status, String style, Integer priority) {

		String path = StatusUtil.getPathFromStatus(status);

		List<Manga> list = new ArrayList<Manga>();

		try {

			BufferedReader br = new BufferedReader(new FileReader(new File(path)));

			String line = br.readLine();
			while (line != null) {

				Manga manga = getMangaFromLine(line);
				if (style.equals("all") || manga.getStyle().equalsIgnoreCase(style)
						|| (manga.getStyle().equalsIgnoreCase("autres") && style.equals("others"))) {
					if (priority == null || (priority != null && manga.getPriority() == priority)) {
						list.add(manga);
					}
				}
				line = br.readLine();

			}

			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		Collections.sort(list);

		return list;

	}

	public static List<Manga> getMangasHavingStyle(List<Manga> mangas, String style) {

		List<Manga> list = new ArrayList<Manga>();

		for (Manga manga : mangas) {
			if (manga.getStyle().equals(style)) {
				list.add(manga);
			}
		}

		return list;

	}

	private static Manga getMangaFromLine(String line) {

		String[] tab = line.split("\\|"); // tab [name, style, priority,
											// chapter]
		Manga manga = new Manga(tab[0].trim());
		try {
			manga.setStyle(tab[1].trim());
			manga.setPriority(Integer.parseInt(tab[2].trim()));
			manga.setChapter(Integer.parseInt(tab[3].trim()));
		} catch (Exception e) {
			System.err.println("erreur (totale ou partielle) lors de la lecture de la ligne du fichier correspondant au manga " + manga.getTitle());
			// e.printStackTrace();
		}

		return manga;

	}

	public static boolean alreadyExists(List<Manga> mangas, String name) {

		boolean res = false;

		for (Manga manga : mangas) {
			if (manga.getTitle().equals(name)) {
				res = true;
			}
		}

		return res;

	}
}
