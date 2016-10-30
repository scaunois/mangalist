package mvc.model;

public class Manga implements Comparable<Manga> {

	private String title;
	private String style;
	private Integer priority;
	private Integer chapter;

	public Manga(String title) {

		this.title = title;
		this.style = "Autres"; // valeur défaut, écrasée plus tard
		this.priority = 0; // valeur défaut, écrasée plus tard
		this.chapter = 1; // valeur défaut, écrasée plus tard

	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Integer getChapter() {
		return chapter;
	}

	public void setChapter(Integer chapter) {
		this.chapter = chapter;
	}

	@Override
	public int compareTo(Manga other) {
		int res = (-1) * this.priority.compareTo(other.priority);
		if (res == 0) {
			return this.title.toLowerCase().compareTo(other.title.toLowerCase());
		}

		return res;
	}

	@Override
	public String toString() {
		return "Manga [name=" + title + ", style=" + style + ", priority=" + priority + ", chapter=" + chapter + "]";
	}

	public String toString2() {
		String s = "";
		s += title;
		s += (style != null ? " - " + style : "");
		s += (priority != null ? " - [" + priority + "]" : "");
		s += (chapter != null ? " - chap." + chapter : "");
		return s;
	}

}
