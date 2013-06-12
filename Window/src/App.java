import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.TabFolder;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.TabItem;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.forms.widgets.FormToolkit;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import jpl.Query;

import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.swt.events.FocusAdapter;
import org.eclipse.swt.events.FocusEvent;
import org.eclipse.wb.swt.SWTResourceManager;


public class App {

	protected Shell shlProyectoCc;
	private final FormToolkit formToolkit = new FormToolkit(Display.getDefault());
	private Text txtTerm;
	private int algorimitSelect;
	private Text txtTerm1;
	private Text txtForm;
	private Text txtTerm2;
	private Text txtTerm1PPD;
	private Text txtTerm2PPD;
	private String Var;
	private Text txtTerm1OC;
	private Text txtTerm2OC;
	private Text txtHH;

	/**
	 * Launch the application.
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			App window = new App();
			window.open();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Open the window.
	 */
	public void open() {
		
		String t1 = "consult('C:/Users/Omar Alvizo/Documents/GitHub/ProyectoCC307/ProyectoCC307.pl')"; 
		Query q1 = new Query(t1); 
		System.out.println( t1 + " " + (q1.hasSolution() ? "succeeded" : "failed") ); 
		
		Display display = Display.getDefault();
		createContents();
		shlProyectoCc.open();
		shlProyectoCc.layout();
		while (!shlProyectoCc.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
	}

	/**
	 * Create contents of the window.
	 */
	protected void createContents() {
		shlProyectoCc = new Shell();
		shlProyectoCc.setBackground(SWTResourceManager.getColor(SWT.COLOR_WHITE));
		shlProyectoCc.setSize(444, 305);
		shlProyectoCc.setText("Proyecto CC307");
		shlProyectoCc.setLayout(null);
		
		
		final TabFolder pestanias = new TabFolder(shlProyectoCc, SWT.NONE);
		pestanias.setBounds(10, 150, 413, 79);
		
		final TabItem tabTerm = new TabItem(pestanias, SWT.NONE);
		tabTerm.setText("Termino");
		
		Composite composite = new Composite(pestanias, SWT.NONE);
		tabTerm.setControl(composite);
		formToolkit.paintBordersFor(composite);
		composite.setLayout(null);
		
		txtTerm = new Text(composite, SWT.BORDER);
		txtTerm.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 1;
			}
		});

		txtTerm.setBounds(71, 10, 325, 21);
		formToolkit.adapt(txtTerm, true, true);
		
		Label lblTermino = new Label(composite, SWT.NONE);
		lblTermino.setBounds(10, 13, 55, 15);
		formToolkit.adapt(lblTermino, true, true);
		lblTermino.setText("Termino:");
		
		Button button = new Button(pestanias, SWT.NONE);
		button.setText("New Button");
		
		TabItem tabForm = new TabItem(pestanias, SWT.NONE);
		tabForm.setText("Formula");
		
		Composite composite_2 = new Composite(pestanias, SWT.NONE);
		tabForm.setControl(composite_2);
		composite_2.setLayout(null);
		formToolkit.paintBordersFor(composite_2);
		
		txtForm = new Text(composite_2, SWT.BORDER);
		txtForm.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 2;
			}
		});
		txtForm.setBounds(71, 10, 325, 21);
		formToolkit.adapt(txtForm, true, true);
		
		Label lblFormula = new Label(composite_2, SWT.NONE);
		lblFormula.setText("Formula:");
		lblFormula.setBounds(10, 13, 55, 15);
		formToolkit.adapt(lblFormula, true, true);
		
		TabItem tbtmPpd = new TabItem(pestanias, SWT.NONE);
		tbtmPpd.setText("PPD");
		
		Composite composite_3 = new Composite(pestanias, SWT.NONE);
		tbtmPpd.setControl(composite_3);
		formToolkit.paintBordersFor(composite_3);
		
		Label label = new Label(composite_3, SWT.NONE);
		label.setText("T1");
		label.setBounds(10, 13, 33, 15);
		formToolkit.adapt(label, true, true);
		
		txtTerm1PPD = new Text(composite_3, SWT.BORDER);
		txtTerm1PPD.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 4;
			}
		});
		txtTerm1PPD.setBounds(54, 10, 136, 21);
		formToolkit.adapt(txtTerm1PPD, true, true);
		
		Label label_1 = new Label(composite_3, SWT.NONE);
		label_1.setText("T2");
		label_1.setBounds(198, 13, 55, 15);
		formToolkit.adapt(label_1, true, true);
		
		txtTerm2PPD = new Text(composite_3, SWT.BORDER);
		txtTerm2PPD.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 4;
			}
		});
		txtTerm2PPD.setBounds(259, 10, 136, 21);
		formToolkit.adapt(txtTerm2PPD, true, true);
		
		TabItem tabOccursCheck = new TabItem(pestanias, 0);
		tabOccursCheck.setText("OccursCheck");
		
		Composite composite_4 = new Composite(pestanias, SWT.NONE);
		composite_4.setLayout(null);
		tabOccursCheck.setControl(composite_4);
		formToolkit.paintBordersFor(composite_4);
		
		txtTerm1OC = new Text(composite_4, SWT.BORDER);
		txtTerm1OC.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 5;
			}
		});
		txtTerm1OC.setBounds(54, 10, 136, 21);
		formToolkit.adapt(txtTerm1OC, true, true);
		
		Label label_2 = new Label(composite_4, SWT.NONE);
		label_2.setText("T1");
		label_2.setBounds(10, 13, 55, 15);
		formToolkit.adapt(label_2, true, true);
		
		txtTerm2OC = new Text(composite_4, SWT.BORDER);
		txtTerm2OC.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 5;
			}
		});
		txtTerm2OC.setBounds(259, 10, 136, 21);
		formToolkit.adapt(txtTerm2OC, true, true);
		
		Label label_3 = new Label(composite_4, SWT.NONE);
		label_3.setText("T2");
		label_3.setBounds(198, 13, 55, 15);
		formToolkit.adapt(label_3, true, true);
		
		TabItem tabUMG = new TabItem(pestanias, SWT.NONE);
		tabUMG.setText("UMG");
		
		Composite composite_1 = new Composite(pestanias, SWT.NONE);
		composite_1.setLayout(null);
		tabUMG.setControl(composite_1);
		formToolkit.paintBordersFor(composite_1);
		
		txtTerm1 = new Text(composite_1, SWT.BORDER);
		txtTerm1.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 3;
			}
		});
		txtTerm1.setBounds(54, 10, 136, 21);
		formToolkit.adapt(txtTerm1, true, true);
		
		Label lblT = new Label(composite_1, SWT.NONE);
		lblT.setText("T1");
		lblT.setBounds(10, 13, 55, 15);
		formToolkit.adapt(lblT, true, true);
		
		txtTerm2 = new Text(composite_1, SWT.BORDER);
		txtTerm2.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 3;
			}
		});
		txtTerm2.setBounds(259, 10, 136, 21);
		formToolkit.adapt(txtTerm2, true, true);
		
		Label lblT_1 = new Label(composite_1, SWT.NONE);
		lblT_1.setText("T2");
		lblT_1.setBounds(198, 13, 55, 15);
		formToolkit.adapt(lblT_1, true, true);
		
		TabItem tabHH = new TabItem(pestanias, 0);
		tabHH.setText("Havel-Hakimi");
		
		Composite composite_5 = new Composite(pestanias, SWT.NONE);
		tabHH.setControl(composite_5);
		formToolkit.paintBordersFor(composite_5);
		
		Label lblSucesions = new Label(composite_5, SWT.NONE);
		lblSucesions.setText("Sucesion de numeros");
		lblSucesions.setBounds(10, 13, 113, 15);
		formToolkit.adapt(lblSucesions, true, true);
		
		txtHH = new Text(composite_5, SWT.BORDER);
		txtHH.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				algorimitSelect = 6;
			}
		});
		txtHH.setBounds(129, 10, 267, 21);
		formToolkit.adapt(txtHH, true, true);
		
		Button btnAnalizar = formToolkit.createButton(shlProyectoCc, "Analizar", SWT.NONE);
		btnAnalizar.setSize(69, 25);
		btnAnalizar.setLocation(349, 235);
		
		Label lblGramatica = new Label(shlProyectoCc, SWT.NONE);
		lblGramatica.setForeground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblGramatica.setBackground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblGramatica.setAlignment(SWT.CENTER);
		lblGramatica.setBounds(10, 10, 146, 15);
		formToolkit.adapt(lblGramatica, true, true);
		lblGramatica.setText("Gramatica:");
		
		Label lblVariablesxyzabcde = new Label(shlProyectoCc, SWT.NONE);
		lblVariablesxyzabcde.setBackground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblVariablesxyzabcde.setForeground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblVariablesxyzabcde.setBounds(10, 31, 146, 15);
		formToolkit.adapt(lblVariablesxyzabcde, true, true);
		lblVariablesxyzabcde.setText("variables([x,y,z,a,b,c,d,e])");
		
		Label lblFuntionsfGH = new Label(shlProyectoCc, SWT.NONE);
		lblFuntionsfGH.setBackground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblFuntionsfGH.setForeground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblFuntionsfGH.setBounds(10, 52, 146, 15);
		formToolkit.adapt(lblFuntionsfGH, true, true);
		lblFuntionsfGH.setText("funtions([f/2, g/1, h/2, i/2]).");
		
		Label lblRelationswV = new Label(shlProyectoCc, SWT.NONE);
		lblRelationswV.setBackground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblRelationswV.setForeground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblRelationswV.setBounds(10, 73, 146, 15);
		formToolkit.adapt(lblRelationswV, true, true);
		lblRelationswV.setText("relations([w/2, k/1]).");
		
		Label lblConsIntergerAnd = new Label(shlProyectoCc, SWT.NONE);
		lblConsIntergerAnd.setBackground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblConsIntergerAnd.setForeground(SWTResourceManager.getColor(SWT.COLOR_GRAY));
		lblConsIntergerAnd.setBounds(10, 94, 146, 15);
		formToolkit.adapt(lblConsIntergerAnd, true, true);
		lblConsIntergerAnd.setText("cons: Interger and Float");
		btnAnalizar.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				
				switch(algorimitSelect){
				case 1:
					if(!txtTerm.getText().isEmpty()){
						if(consultProlog(txtTerm.getText(), "isTerm")){
							MessageDialog.openInformation(shlProyectoCc, "Es un termino", txtTerm.getText()+" : si es un Termino del lenguaje");  
						}
						else{
							MessageDialog.openError(shlProyectoCc, "Error", txtTerm.getText()+" : no es un Termino del lenguaje");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
					break;
				case 2:
					if(!txtForm.getText().isEmpty()){
						if(consultProlog(txtForm.getText(), "isFormula")){
							MessageDialog.openInformation(shlProyectoCc, "Es una formula", txtForm.getText()+" : si es una formula del lenguaje");  
						}
						else{
							MessageDialog.openError(shlProyectoCc, "Error", txtForm.getText()+" : no es una Formula del lenguaje");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
						
					break;
				case 3:
					if(!txtTerm1.getText().isEmpty() && !txtTerm2.getText().isEmpty()){
						if(consultProlog(txtTerm1.getText()+","+txtTerm2.getText(), "unifyRobinson")){
							MessageDialog.openInformation(shlProyectoCc, "El UMG es: ", Var);  
						}
						else{
							MessageDialog.openError(shlProyectoCc, "Error", txtForm.getText()+" Error en los terminos");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
						
					break;
				case 4:
					if(!txtTerm1PPD.getText().isEmpty() && !txtTerm2PPD.getText().isEmpty()){
						if(consultProlog(txtTerm1PPD.getText()+","+txtTerm2PPD.getText(), "primerParDiscordancia")){
							MessageDialog.openInformation(shlProyectoCc, "El PPD es: ", Var);  
						}
						else{
							MessageDialog.openError(shlProyectoCc, "Error", txtForm.getText()+"No tiene PPD");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
						
					break;
				case 5:
					if(!txtTerm1OC.getText().isEmpty() && !txtTerm2OC.getText().isEmpty()){
						if(consultProlog(txtTerm1OC.getText()+","+txtTerm2OC.getText(), "occursCheck")){
							MessageDialog.openError(shlProyectoCc, "Error ", "Si hay error de OccurCheck");  
						}
						else{
							MessageDialog.openInformation(shlProyectoCc, "Occurs Check", "No hay error de OccursCheck");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
						
					break;
				case 6:
					if(!txtHH.getText().isEmpty()){
						if(consultProlog(txtHH.getText(), "havelHakimi")){
							MessageDialog.openInformation(shlProyectoCc, "Es un sucesion de valencias de un grafo", txtHH.getText()+" : si es una sucesion de valencias de un grafo");  
						}
						else{
							MessageDialog.openError(shlProyectoCc, "Error", txtHH.getText()+" : no es una sucesion de valencias de un grafo");  
						}
					}
					else
						MessageDialog.openError(shlProyectoCc, "Error", " Celda vacia!");  
					break;
				
				}
			}
		});

	}
	
	public boolean consultProlog(String term, String Algoritmo){
		
		String t2 = ""; 
		Query q2; 
		
		
		switch(algorimitSelect){
		
		case 1:
		case 2:
		case 5:
		case 6:
			
			try{
				t2 = Algoritmo+"("+term+")"; 
				q2 = new Query(t2); 
				return (q2.hasSolution() ? true : false);
			}catch(Exception e){
				return false;
			}
			
		case 3:
			t2 = Algoritmo+"("+term+", X)"; 
			q2 = new Query(t2); 
			
			try{
				Var =  " UMG = " + q2.oneSolution().get("X"); 
			}catch(Exception e){
				return false;
			}
			
			return (q2.hasSolution() ? true : false);
		case 4:
			t2 = Algoritmo+"("+term+", X)"; 
			q2 = new Query(t2); 
			
			try{
				Var =  " PPD = " + q2.oneSolution().get("X"); ; 
			}catch(Exception e){
				return false;
			}
			
		
			return (q2.hasSolution() ? true : false);
		}
		return false;
	}
}
