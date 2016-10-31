package util;

public class StatusUtil {

	public static String getPathFromStatus(String status) {

		String path = null;

		switch (status) {
		case "in_progress":
			path = "C:/mangalist/mangaList_inProgress.txt";
			break;
		case "finished":
			path = "C:/mangalist/mangaList_finished.txt";
			break;
		case "to_read":
			path = "C:/mangalist/mangaList_toRead.txt";
			break;
		default:
			path = "C:/mangalist/mangaList_inProgress.txt";
		}

		return path;

	}

}
