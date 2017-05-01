package mvc.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import service.singleton.ConfigurationSvc;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/ajax_save_properties" })
public class AjaxController_saveProperties extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String backgroundColor = request.getParameter("backgroundColor");
		String textColor = request.getParameter("textColor");
		saveBackgroundAndTextColor(backgroundColor, textColor);
		// reload the file to take changes into account
		ConfigurationSvc.getInstance().loadConfiguration();

	}

	private void saveBackgroundAndTextColor(String backgroundColor, String textColor) {

		try {
			FileUtils.writeStringToFile(new File("C:/mangalist/mangalist.properties"), "background=" + backgroundColor
					+ "\n" + "text=" + textColor);
		} catch (IOException e) {
			System.err.println("Impossible de sauvegarder les préférences.");
			e.printStackTrace();
		}

	}
}
