package com.example.entity;

public class ScoreGoods {

    /**ID */
    private Integer id;
    /**物品名称 */
    private String name;
    /**简介 */
    private String descr;
    /**封面图片 */
    private String img;
    /**剩余可兑换数量 */
    private Integer num;
    /**计量单位 */
    private String unit;
    /**单个积分 */
    private String score;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }
}
