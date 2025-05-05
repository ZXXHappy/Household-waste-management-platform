package com.example.entity;

public class RecoveryRecords {

    /**主键 */
    private Integer id;
    /**用户 */
    private Integer userId;
    /**可回收垃圾 */
    private Integer garbageId;
    /**社区 */
    private Integer communityId;
    /**回收点 */
    private Integer siteId;
    /**回收数量 */
    private Integer num;
    /**总计积分 */
    private Integer score;
    /**申请时间 */
    private String time;
    /**备注 */
    private String remark;
    /**可回收垃圾照片 */
    private String img;
    /**回收状态 */
    private String status;
    /**拒绝备注 */
    private String rejectReason;
    private String userName;
    private String garbageName;
    private String communityName;
    private String siteName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGarbageName() {
        return garbageName;
    }

    public void setGarbageName(String garbageName) {
        this.garbageName = garbageName;
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

    public Integer getGarbageId() {
        return garbageId;
    }

    public void setGarbageId(Integer garbageId) {
        this.garbageId = garbageId;
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

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }
}
