package com.example.entity;

public class Popularize {

    /**ID */
    private Integer id;
    /**标题 */
    private String title;
    /**简介 */
    private String descr;
    /**封面 */
    private String img;
    /**小图1 */
    private String thumbnail1;
    /**小图2 */
    private String thumbnail2;
    /**小图3 */
    private String thumbnail3;
    /**主体内容 */
    private String content;
    /**分类 */
    private Integer typeId;
    /**浏览量 */
    private Integer viewCount;
    private String typeName;

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public String getThumbnail1() {
        return thumbnail1;
    }

    public void setThumbnail1(String thumbnail1) {
        this.thumbnail1 = thumbnail1;
    }

    public String getThumbnail2() {
        return thumbnail2;
    }

    public void setThumbnail2(String thumbnail2) {
        this.thumbnail2 = thumbnail2;
    }

    public String getThumbnail3() {
        return thumbnail3;
    }

    public void setThumbnail3(String thumbnail3) {
        this.thumbnail3 = thumbnail3;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }
}