package service.singleton;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;

public class ConfigurationSvc {

	private static ConfigurationSvc instance;

	private String backgroundColor;
	private String textColor;

	private ConfigurationSvc() {
		loadConfiguration();
	}

	public static ConfigurationSvc getInstance() {
		if (instance == null) {
			instance = new ConfigurationSvc();
		}
		return instance;
	}

	@SuppressWarnings("unchecked")
	public void loadConfiguration() {

		List<String> properties = null;
		try {
			properties = FileUtils.readLines(new File("C:/mangalist/mangalist.properties"));
		} catch (IOException e) {
			System.err.println("Erreur lors du chargement de la configuration de l'application mangalist.");
			e.printStackTrace();
		}

		this.backgroundColor = properties.get(0).replaceAll("background=", "");
		this.textColor = properties.get(1).replaceAll("text=", "");

	}

	public String getBackgroundColor() {
		return this.backgroundColor;
	}

	public String getTextColor() {
		return this.textColor;
	}

}
