//This applet is manufactured by: © 1998 J.Giesen - 6/14/1998
import java.applet.Applet;
import java.util.Date;
import java.awt.*;

public class DayNight125d extends Applet {

	String versStr="  - v 1.25d";
	Date dat;
	int year, month, date, day, hours, minutes, seconds;		
	Image bild;	
	String[] dayArray = new String[7];
	String monthArray[] = new String[12];				
	Graphics g;
	Button button;
	public DNloc time;
	public Choice timeChoice;
	public String timeString;	
	public int locOffset;
	int browserOffset;
	int xMouse=0, yMouse=0;
	int xOben=40,  xL=20;
	double latitude, longitude, dec, GHA, hoehe=0.0;
	double K = Math.PI/180.0;
	boolean clicked;
	String dayStr, monthStr, hourStr;
	double theTime;
	
	
	
	//-----------------------------------------------------------------
	public double JD (int date, int month, int year, double STD) {
			
		double A, B;
									
		//A = 10000.0*year + 100.0*month + date;
		if (month<=2) {month=month+12; year=year-1;}

		B = (int)(year/400) - (int)(year/100) +(int)(year/4);			
		A = 365.0*year - 679004.0;
		double MJD = A + B + (int)(30.6001*(month+1)) + date + STD/24.0;
		return MJD + 2400000.5;		
	}
	
	//---------------
	public String monthString(int m)
		{
		String monthArray[] = new String[12];
		monthArray[0] = "Jan"; monthArray[1] = "Feb";
		monthArray[2] = "Mär"; monthArray[3] = "Apr";
		monthArray[4] = "Mai"; monthArray[5] = "Jun";
		monthArray[6] = "Jul"; monthArray[7] = "Aug";
		monthArray[8] = "Sep"; monthArray[9] = "Okt";
		monthArray[10] = "Nov"; monthArray[11] = "Dez";
		if (m<1) return "month = " + m;
		else return monthArray[m-1];
		}
		
	public String dayString(double jd)
	{
	long num;
	String dayArray[] = new String[12];
	dayArray[1] = "Mon"; dayArray[2] = "Die";
	dayArray[3] = "Mit"; dayArray[4] = "Don";
	dayArray[5] = "Fre"; dayArray[6] = "Sam";
	dayArray[7] = "Son";

 
  	num = (long)(jd+0.5);
  	num = num - (long)(num/7)*7 + 1;
   
	return dayArray[(int)num];
	}				
	
	public double sunL(double T) // mean longitude of the Sun
	{
		double L;
		
		//L = 280.4665 + 36000.7698*T;
		L = 280.46645 + 36000.76983*T + 0.0003032*T*T;
		double tau = T/10.0;
		L = 280.4664567 + 360007.6982779*tau + 0.03032028*tau*tau + tau*tau*tau/49931 - tau*tau*tau*tau/15299 + tau*tau*tau*tau*tau/1988000;
		
		L = L % 360;		
		if (L<0) L = L + 360;
		return L;			
	}
	
	public double deltaPSI(double T) // nutation in longitude, Meeus p. 132
	{
		final double K = Math.PI/180.0;
		double deltaPsi, omega, LS, LM;
				
		LS = sunL(T);
		
		LM = 218.3165 + 481267.8813*T;		
		LM = LM % 360;		
		if (LM<0) LM = LM + 360;
		
		omega = 125.04452 - 1934.136261*T + 0.0020708*T*T + T*T*T/450000; // long. of the ascending node of the Moon
		deltaPsi = -17.2*Math.sin(K*omega) - 1.32*Math.sin(K*2*LS) - 0.23*Math.sin(K*2*LM) + 0.21*Math.sin(K*2*omega);
		deltaPsi = deltaPsi/3600.0;
		
		return deltaPsi;	
	}
	
	public double EPS(double T) // obliquity
	{
		final double K = Math.PI/180.0;
		double LS = sunL(T);
		double LM = 218.3165 + 481267.8813*T;	
		double eps0 =  23.0 + 26.0/60.0 + 21.448/3600.0 - (46.8150*T + 0.00059*T*T - 0.001813*T*T*T)/3600;
		double omega = 125.04452 - 1934.136261*T + 0.0020708*T*T + T*T*T/450000; // long. of the ascending node of the Moon		
		double deltaEps = (9.20*Math.cos(K*omega) + 0.57*Math.cos(K*2*LS) + 0.10*Math.cos(K*2*LM) - 0.09*Math.cos(K*2*omega))/3600;
		
		return eps0 + deltaEps;	
	}
	
	public double eot(int date, int month, int year, double UT)
	{		
		final double K = Math.PI/180.0;		
		double  T = (JD(date, month, year,UT) - 2451545.0) / 36525.0;
		
		double eps = EPS(T);	
		double RA = RightAscension(T);
		double LS = sunL(T);
		double deltaPsi = deltaPSI(T);
						
		double E = LS - 0.0057183 - RA + deltaPsi*Math.cos(K*eps);// Meeus p. 171
		if (E>5) E = E - 360.0;			
		E = E*4; // deg. to min
				
		return E;		
	}
	
	public double RightAscension(double T) // apparent RA of the Sun
	{	
		final double K = Math.PI/180.0;
				
		double L, M, C, lambda;
		double RA, eps, delta, theta;	
						
		L = sunL(T);
		
		M = 357.52910 + 35999.05030*T - 0.0001559*T*T - 0.00000048*T*T*T; // mean anomaly of the Sun
		M = M % 360;		
		if (M<0) M = M + 360;
				
		C = (1.914600 - 0.004817*T - 0.000014*T*T)*Math.sin(K*M);
		C = C + (0.019993 - 0.000101*T)*Math.sin(K*2*M);
		C = C + 0.000290*Math.sin(K*3*M);
		
		theta = L + C; // true longitude of the Sun
						
		eps = EPS(T);				
		eps = eps + 0.00256*Math.cos(K*(125.04 - 1934.136*T));
		
		lambda = theta - 0.00569 - 0.00478*Math.sin(K*(125.04 - 1934.136*T)); // apparent longitude of the Sun
								
		RA = Math.atan2(Math.cos(K*eps)*Math.sin(K*lambda), Math.cos(K*lambda));				
		RA = RA/K;
		if (RA<0) RA = RA + 360.0;		
		
		delta = Math.asin(Math.sin(K*eps)*Math.sin(K*lambda));
		delta = delta/K;
		
		//DEC = delta;
				
		return RA;		
	}
	
	
	public double computeDeclination (int T, int M, int J, double STD) {
		
		long N;
		double X, XX, P, NN;
		double Ekliptik, J2000;
	
		 N = 365 * J + T + 31 * M - 46;		 
		 if (M<3) 
			N = N + (int)((J - 1) / 4);
		else
			 N = N - (int)(0.4 * M + 2.3) + (int)(J / 4.0);
			 
		X = (N - 693960) / 1461.0;
		X = (X - (int)X) * 1440.02509 + (int)X * 0.0307572;
		X = X + STD/24.0 * 0.9856645 + 356.6498973;
		X = X + 1.91233 * Math.sin(0.9999825 * X * K);
		X = (X + Math.sin(1.999965 * X * K) / 50.0 + 282.55462)/360.0;
		X = (X - (int)X) * 360.0;
		
	 	J2000 = (J-2000)/100.0;
	 	Ekliptik = 23.43929111 - (46.8150 + (0.00059 - 0.001813 * J2000) * J2000) * J2000 / 3600.0;
		
		X =  Math.sin(X * K) *  Math.sin(K * Ekliptik);

		return Math.atan(X / Math.sqrt(1.0 - X * X)) / K + 0.00075;	
	}
	
	public double computeGHA (int T, int M, int J, double STD) {
	
		long N;
		double X, XX, P, NN;
		
		 N = 365 * J + T + 31 * M - 46;		 
		 if (M<3) 
			N = N + (int)((J - 1) / 4);
		else
			 N = N - (int)(0.4 * M + 2.3) + (int)(J / 4.0);
			 
		P = STD/24.0;
		X = (P + N - 7.22449E5) * 0.98564734 + 279.306;
		X = X * K;
		XX = -104.55 * Math.sin(X) - 429.266 * Math.cos(X) + 595.63 * Math.sin(2.0 * X) - 2.283 * Math.cos(2.0 * X);
		XX = XX + 4.6 * Math.sin(3.0 * X) + 18.7333 * Math.cos(3.0 * X);
		XX = XX - 13.2 * Math.sin(4.0 * X) - Math.cos(5.0 * X) - Math.sin(5.0 * X) / 3.0 + 0.5 * Math.sin(6.0 * X) + 0.231;
		XX = XX / 240.0 + 360.0 * (P + 0.5);
		if (XX > 360) 
			XX = XX - 360.0;  
 		return XX;				
	}
	
	public double computeHeight() {
		
		double sinHeight, height;
			
		sinHeight =Math.sin(dec*K)*Math.sin(latitude*K) + Math.cos(dec*K)*Math.cos(K*latitude)*Math.cos(K*(GHA+longitude));						
		height = Math.asin(sinHeight);
		height = height/K;		
		return height;
	}
	
	public double computeAzimut() {	
		double cosAz, Az;
			
		cosAz = (Math.sin(dec*K) - Math.sin(latitude*K)*Math.sin(hoehe*K))/(Math.cos(hoehe*K)*Math.cos(K*latitude));						
		Az = Math.PI/2.0 - Math.asin(cosAz);
		Az = Az/K;
		if (Math.sin(K*(GHA+longitude)) < 0)
			Az = Az;	
		if (Math.sin(K*(GHA+longitude)) > 0)
			Az = 360.0 - Az;			
		return Az;
	}
	
	
	public void myDayMonth() {
	
		dayArray[0] = "Sunday"; dayArray[1] = "Monday";
		dayArray[2] = "Tuesday"; dayArray[3] = "Wednesday";
		dayArray[4] = "Thursday"; dayArray[5] = "Friday";
		dayArray[6] = "Saturday";
		
		monthArray[0] = "January"; monthArray[1] = "February";
		monthArray[2] = "March"; monthArray[3] = "April";
		monthArray[4] = "May"; monthArray[5] = "June";
		monthArray[6] = "July"; monthArray[7] = "August";
		monthArray[8] = "September"; monthArray[9] = "October";
		monthArray[10] = "November"; monthArray[11] = "December";
	}
	
	
				
	public void init ( ) {
	
		//String bildname;
		Image picture;
		Rectangle r;
		MediaTracker tracker;	
	
		myDayMonth();		
							
		bild = getImage(getDocumentBase(),"applet/map.gif");
		
		dat = new Date( );		
		
		r = this.bounds();
		picture = createImage(r.width,r.height);
		g = picture.getGraphics();

		tracker = new MediaTracker(this);
		tracker.addImage(bild,0);
	
		try {tracker.waitForID(0);} catch(Exception e) { };
		
		Panel panel = new Panel();
		add("Buttons", panel);
		add("Choice", panel);
				
		time = new DNloc();
		timeChoice = new Choice();
		time.timeMenu(timeChoice);
		panel.add(timeChoice);
								
		button = new Button();
		button.setLabel("Aktualisieren");
		panel.add(button);
		
		dat = new Date( );
		browserOffset = dat.getTimezoneOffset();
		browserOffset = -browserOffset/60;//*
		locOffset = browserOffset;
						
		timeString = browserOffset + " h";
		if (browserOffset >0) timeString = "+" + timeString;
		timeString = " " + timeString; 	
		timeChoice.select(timeString);
		
		resize(size().width,size().height);
		clicked = false;
							
	}
	
			
	public int computeLat(int longitude, double dec) {
	
		double tan, itan;
			
		tan = - Math.cos(longitude*K)/Math.tan(dec*K);						
		itan = Math.atan(tan);
		itan = itan/K;
					
		return (int)Math.round(itan);
	}
							
			
	public void paint ( Graphics g ) {
	
		int x0=180, y0=90+xOben, left = 370+xL;
		double STD, GHA12, equation, diff, azimuth;
		int Radius = 6;
		int x, y, yy, yy1;
		String s;
		int p, min;
		int xGnomon, yGnomon;
		double gnomon;
		double jd;
		String datum, str;
		int hour;

		
		//Font f = g.getFont();
		g.setFont(new Font("Helvetica", Font.PLAIN, 9));
		g.drawString("Tag & Nacht Applet" + versStr,left-30,245);
		g.drawString("© 1998-2000 Jürgen Giesen",left-30,260);
		g.drawString("www.jgiesen.de",left-30,275);
		//g.setFont(f);
		
		Font f = new Font("Helvetica", Font.PLAIN, 10);
		g.setFont(f);
		


		g.drawImage(bild,xL,xOben,this);
		g.drawRect(xL,xOben,360,178);
				
		g.drawString("Zeitverschiebung gegenüber",xL,xOben-23);
		g.drawString("Greenwich Mean Time (GMT)",xL,xOben-10);
						
		dat = new Date( );
		
		day = dat.getDay();
			
		date = dat.getDate();		
				
		month = dat.getMonth();				
						
		year = dat.getYear();
					
		hours = dat.getHours();
		hour = hours;
		
		minutes = dat.getMinutes();		
				
		seconds = dat.getSeconds();
				

		if (minutes>9) str = ":"; else str = ":0";		
		hourStr = (int)hour + str + minutes;
		if (hours<10) hourStr = " " + hourStr;		
												
		theTime = hours + minutes/60.0 + seconds/3600.0; 
		jd = JD(date, month+1, year+1900, theTime);

		str = ":" + seconds;
		if (seconds<10) str = ":0" + seconds;
		else str = ":" + seconds;
		datum = dayString(jd) + "  " + date + ". " + monthArray[month] + " " + (year+1900) + " um " + hourStr + str;
		g.drawString(datum,xL,245);
						
		// compute and write Declination		
		STD = 1.0*(hours-locOffset) + minutes/60.0 + seconds/3600.0;
		dec = computeDeclination(date, month+1, year+1900, STD);
		str = str.valueOf(Math.round(100.0*dec)/100.0);
		s = str.substring(0,str.indexOf(".")+2);
		g.setColor(Color.blue);											
		//g.drawString("Declin.=" + s + " degs",left,160);
		g.drawString("Declin.   " + s + " degs",left,60);
		
		// compute and write Greenwich Hour Angle
		GHA = computeGHA(date, month+1, year+1900, STD);
		str = str.valueOf(Math.round(10.0*GHA)/10.0);		
		s = str.substring(0,str.indexOf(".")+2);
		g.drawString("GHA       " + s + " degs",left,80);
				
		
		equation = eot(date, month+1, year+1900, STD);//4.31		
		diff = Math.abs(equation) - (int)Math.abs(equation);//4.57				
		min = (int)Math.round(diff*60.0);
		if (min==60)
			{
			min=0;
			if (equation>=0) equation=equation+1.0;// 3.75
			else equation=equation-1.0;
			}		
		if (min>9) str = ":"; else str = ":0";
		String eqtStr = "" + (int)equation + str + min + " min";
		if ((equation<0) && ((int)equation==0)) eqtStr = "-" + (int)equation + str + min + " min";// 4.57
		g.drawString("Equation of Time",left,100);
		g.drawString("                      " + eqtStr,left,113);

		
				
		g.setColor(Color.black);
																			
		if (browserOffset >0 ) str="+";
		else str="";
		g.drawString("Systemzeit des Computers = GMT " + str + browserOffset + " h",xL,275);
	
		hour = dat.getHours() - locOffset;
		timeString = locOffset + " h";
		
		if (hour<0)  hour=hour+24;
		if (hour>=24)  hour=hour-24;
		
		if (minutes > 9) str =  ":";
		else str =":0";
		str = hour + str + minutes;	
			
		if (seconds > 9) s = ":";
		else s = ":0";
					
		str = str + s + seconds;
				
		g.setColor(Color.blue);
		g.drawString(str + " GMT",xL,260);
		g.setColor(Color.red);
				
		x = x0 - (int)Math.round(GHA);
		if (x < 0) x = x + 360;
		if (x > 360) x = x - 360;
		
		// equator line
		int xx=xL;
		g.setColor(Color.gray);
		g.drawLine(xL,y0,xL+2*x0-2,y0);
		g.drawLine(xL+x0,y0-90,xL+x0,y0+90);
		yy1 = (int)Math.round(y0-23.5);
		int yy2 = (int)Math.round(y0+23.5);
		y = (int)Math.round(y0-90+23.5);
		yy = (int)Math.round(y0+90-23.5);
		
		for (int i=0;  i<60; i++) {											
			g.drawLine(xx,yy1,xx+2,yy1);						
			g.drawLine(xx,yy2,xx+2,yy2);						
			g.drawLine(xx,y,xx+2,y);						
			g.drawLine(xx,yy,xx+2,yy);			
			xx = xx + 6;	
		}

		y = y0 - (int)Math.round(dec);
					
		g.setColor(Color.yellow);		
		g.fillOval(xL+x-Radius,y-Radius,2*Radius,2*Radius);
		
		g.setColor(Color.red);			
		g.drawOval(xL+x-Radius-1,y-Radius-1,2*Radius+2,2*Radius+2);
		
				
		g.setXORMode(Color.black);//white
		
		//g.setColor(Color.white);
		
		int F;
		if (dec>0) F=1;
		else F=-1;
		
		
		for (int i=-x; x+i<2*x0; i++) {
			yy = computeLat(i, dec);
			yy1 = computeLat(i+1, dec);			
			g.drawLine(xL+x+i,y0-yy,xL+x+i+1,y0-yy1);			
		
			g.drawLine(xL+x+i,y0-yy,xL+x+i,y0+F*90-2);
					
			}
			
	
			
		g.setPaintMode();
		
		g.setColor(Color.black);			
							
		longitude = xMouse-xL-180;
		latitude = 90-yMouse+xOben;
		str = str.valueOf((int)Math.abs(latitude));
		if (latitude>0) str=str + " N";
		else str=str + " S";		
		str = str + "  " + str.valueOf((int)Math.abs(longitude));
		if (longitude>0) str=str + " E";
		else str=str + " W";
		hoehe = computeHeight();
		g.setColor(Color.red);	
		if (clicked) {
			g.drawString(str,260,245);		
			str = "Elev.  = " + str.valueOf((int)Math.round(hoehe)) + " deg";
			g.drawString(str,260,260);
			g.drawOval(xMouse-3,yMouse-3,6,6);}
		else {
			g.drawString("Click the map to see",250,245);
			g.drawString("the shadow",250,260);
			g.drawString("and more !",250,275);
			}
		azimuth = computeAzimut();
		if (clicked) {			
			str = "Azim. = " + str.valueOf((int)Math.round(azimuth)) + " deg";
			g.drawString(str,260,275);
			}
		
		if ((hoehe>0) && clicked) {							
			azimuth =azimuth - 180.0;
			gnomon = 50.0/Math.tan(K*hoehe);
			yGnomon = (int)Math.round(gnomon*Math.cos(K*azimuth));
			xGnomon = (int)Math.round(gnomon*Math.sin(K*azimuth));
			g.drawLine(xMouse,yMouse,xMouse+xGnomon,yMouse-yGnomon);			
		}
		
		g.setColor(Color.red);
		g.drawRect(1,1,size().width-2,size().height-2);
		g.setFont(new Font("Helvetica", Font.PLAIN, 9));
		g.setColor(Color.black);
		//g.drawString("Map copyright by Apple Computer Inc.",125,228);																	
	}
		
	
	
	public boolean action(Event event, Object eventobject) {
	
		if (event.target instanceof Button) {};
					
		if (event.target==timeChoice) {				
				timeString = timeChoice.getSelectedItem();	
				locOffset = time.getTimeZone(timeString);
				locOffset = locOffset;
				timeChoice.select(timeString);				
			}	
		g.clipRect(0,0,size().width,size().height);	
		repaint(); 													
		return true;
	}

	
	public boolean mouseDown(Event event, int x, int y) {
	
	xMouse = x;
	yMouse = y;
	if ((xMouse>=xL) && (xMouse<=xL+360) && (yMouse>=xOben) && (yMouse<=xOben+180))
		{
		clicked = true;
		repaint();		
		}
		else clicked = false;
		return true;	
	}				
}

class DNloc {
					
	
	public void timeMenu(Choice timeChoice) {
		
		timeChoice.addItem(" 0 h");
		timeChoice.addItem(" -1 h");
		timeChoice.addItem(" +1 h");
		timeChoice.addItem(" -2 h");
		timeChoice.addItem(" +2 h");
		timeChoice.addItem(" -3 h");
		timeChoice.addItem(" +3 h");
		timeChoice.addItem(" -4 h");
		timeChoice.addItem(" +4 h");
		timeChoice.addItem(" -5 h");
		timeChoice.addItem(" +5 h");
		timeChoice.addItem(" -6 h");
		timeChoice.addItem(" +6 h");
		timeChoice.addItem(" -7 h");
		timeChoice.addItem(" +7 h");
		timeChoice.addItem(" -8 h");
		timeChoice.addItem(" +8 h");
		timeChoice.addItem(" -9 h");
		timeChoice.addItem(" +9 h");
		timeChoice.addItem(" -10 h");
		timeChoice.addItem(" +10 h");
		timeChoice.addItem(" -11 h");
		timeChoice.addItem(" +11 h");
	}
	
	public int getTimeZone(String timeString) {
	
		int timeOffset = 0;
	
		if (timeString.equals("0 h")) timeOffset = 0;
		else if (timeString.equals(" -1 h")) timeOffset = -1;
		else if (timeString.equals(" +1 h")) timeOffset = +1;
		else if (timeString.equals(" -2 h")) timeOffset = -2;
		else if (timeString.equals(" +2 h")) timeOffset = +2;
		else if (timeString.equals(" -3 h")) timeOffset = -3;
		else if (timeString.equals(" +3 h")) timeOffset = +3;
		else if (timeString.equals(" -4 h")) timeOffset = -4;
		else if (timeString.equals(" +4 h")) timeOffset = +4;
		else if (timeString.equals(" -5 h")) timeOffset = -5;
		else if (timeString.equals(" +5 h")) timeOffset = +5;
		else if (timeString.equals(" -6 h")) timeOffset = -6;
		else if (timeString.equals(" +6 h")) timeOffset = +6;
		else if (timeString.equals(" -7 h")) timeOffset = -7;
		else if (timeString.equals(" +7 h")) timeOffset = +7;
		else if (timeString.equals(" -8 h")) timeOffset = -8;
		else if (timeString.equals(" +8 h")) timeOffset = +8;
		else if (timeString.equals(" -9 h")) timeOffset = -9;
		else if (timeString.equals(" +9 h")) timeOffset = +9;
		else if (timeString.equals(" -10 h")) timeOffset = -10;
		else if (timeString.equals(" +10 h")) timeOffset = +10;
		else if (timeString.equals(" -11 h")) timeOffset = -11;
		else if (timeString.equals(" +11 h")) timeOffset = +11;
		
		return timeOffset;
	}				
}
