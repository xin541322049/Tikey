package cn.tikey.helper;

/**
 * 用于封装XY统计图中的横纵坐标对应值的范型类
 * Created by Croff on 2017/6/3.
 */
public class XYChartStatistics<X, Y> {

    private X x;    //横坐标对应值
    private Y y;    //纵坐标对应值

    public XYChartStatistics(X x, Y y) {
        this.x = x;
        this.y = y;
    }

    public X getX() {
        return x;
    }

    public void setX(X x) {
        this.x = x;
    }

    public Y getY() {
        return y;
    }

    public void setY(Y y) {
        this.y = y;
    }
}
