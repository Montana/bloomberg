public class Stock {

	private double earnings;
	private int numOfShares;
	private double dividentRatio;
	private double initialPrice;
	private double marketValuePerShare;
	private double volatility;
	private String ticker;	
	private double netWorth;
	private int quantity;
	private int counter;
  private int ratio; 
	
	public int getCounter() {
		return counter;
	}

	public void setCounter(int counter) {
		this.counter = counter;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	private double averageBoughtPrice;
	
	public double getAverageBoughtPrice() {
		return averageBoughtPrice;
	}

	public void setAverageBoughtPrice(double averageBoughtPrice) {
		this.averageBoughtPrice = averageBoughtPrice;
	}

	public double getNetWorth() {
		return netWorth;
	}

	public void setNetWorth(double netWorth) {
		this.netWorth = netWorth;
	}

	public double getEarnings() {
		return earnings;
	}

	public void setEarnings(double earnings) {
		this.earnings = earnings;
	}

	public int getNumOfShares() {
		return numOfShares;
	}

	public void setNumOfShares(int numOfShares) {
		this.numOfShares = numOfShares;
	}

	public double getDividentRatio() {
		return dividentRatio;
	}

	public void setDividentRatio(double dividentRatio) {
		this.dividentRatio = dividentRatio;
	}

	public double getInitialPrice() {
		return initialPrice;
	}

	public void setInitialPrice(double initialPrice) {
		this.initialPrice = initialPrice;
	}

	public double getMarketValuePerShare() {
		return marketValuePerShare;
	}

	public void setMarketValuePerShare(double marketValuePerShare) {
		this.marketValuePerShare = marketValuePerShare;
	}

	public double getVolatility() {
		return volatility;
	}

	public void setVolatility(double volatility) {
		this.volatility = volatility;
	}

	public String getTicker() {
		return ticker;
	}

	public void setTicker(String ticker) {
		this.ticker = ticker;
	}

