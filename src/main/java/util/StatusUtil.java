package util;

public class StatusUtil {

	public static String getPathFromStatus(String status) {

		String path = null;

		switch (status) {
		case "IN_PROGRESS":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_inProgress.txt";
			break;
		case "FINISHED":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_finished.txt";
			break;
		case "TO_READ":
			path = "C:/Users/Administrateur.000/Desktop/mangaList_toRead.txt";
			break;
		}

		return path;

	}

}
