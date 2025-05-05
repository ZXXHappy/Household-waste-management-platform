package com.example.entity;

import java.util.List;

public class GarbageLaunch {

    /**ID */
    private Integer id;
    /**用户 */
    private Integer userId;
    /**社区 */
    private Integer communityId;
    /**投放点 */
    private Integer siteId;
    /**垃圾类型 */
    private String type;
    /**垃圾照片 */
    private String img;
    /**投放时间 */
    private String time;
    private String communityName;
    private String siteName;
    private String userName;

    // 查询参数
    private List<Integer> communityIds;

    public List<Integer> getCommunityIds() {
        return communityIds;
    }

    public void setCommunityIds(List<Integer> communityIds) {
        this.communityIds = communityIds;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Integer getSiteId() {
        return siteId;
    }

    public void setSiteId(Integer siteId) {
        this.siteId = siteId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}