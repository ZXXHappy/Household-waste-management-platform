package com.example.entity;

public class Community {

    /**主键ID */
    private Integer id;
    /**社区名称 */
    private String name;
    /**社区地址 */
    private String address;
    /**社区图片 */
    private String img;
    /**社区负责人 */
    private Integer managerId;
    private String managerName;
    private String managerPhone;
    private Integer recoverySiteCount;

    public Integer getRecoverySiteCount() {
        return recoverySiteCount;
    }

    public void setRecoverySiteCount(Integer recoverySiteCount) {
        this.recoverySiteCount = recoverySiteCount;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }
}