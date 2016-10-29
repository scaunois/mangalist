package util;

public class StatusUtil {

	public static String getPathFromStatus(String status) {

		String path = null;

		switch (status) {
		case "in_progress":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_inProgress.txt";
			break;
		case "finished":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_finished.txt";
			break;
		case "to_read":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_toRead.txt";
			break;
		default:
			path = "C:/Users/Administrateur.000/Desktop/mangaList_inProgress.txt";
		}

		return path;

	}

}
