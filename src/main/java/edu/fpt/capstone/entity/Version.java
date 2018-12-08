/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.fpt.capstone.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "version", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Version.findAll", query = "SELECT v FROM Version v")
    , @NamedQuery(name = "Version.findById", query = "SELECT v FROM Version v WHERE v.id = :id")
    , @NamedQuery(name = "Version.findByVersionName", query = "SELECT v FROM Version v WHERE v.versionName = :versionName")
    , @NamedQuery(name = "Version.findByIsCurrent", query = "SELECT v FROM Version v WHERE v.isCurrent = :isCurrent")
    , @NamedQuery(name = "Version.findByReleasedDate", query = "SELECT v FROM Version v WHERE v.releasedDate = :releasedDate")})
public class Version implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Column(name = "version_name", length = 45)
    private String versionName;
    @Basic(optional = false)
    @Column(name = "is_current", nullable = false)
    private boolean isCurrent;
    @Column(name = "released_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date releasedDate;
    @JoinColumn(name = "created_by", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private User createdBy;

    public Version() {
    }

    public Version(Integer id) {
        this.id = id;
    }

    public Version(Integer id, String versionName, boolean isCurrent, User createdBy) {
        this.id = id;
        this.versionName = versionName;
        this.isCurrent = isCurrent;
        this.createdBy = createdBy;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getVersionName() {
        return versionName;
    }

    public void setVersionName(String versionName) {
        this.versionName = versionName;
    }

    public boolean getIsCurrent() {
        return isCurrent;
    }

    public void setIsCurrent(boolean isCurrent) {
        this.isCurrent = isCurrent;
    }

    public Date getReleasedDate() {
        return releasedDate;
    }

    public void setReleasedDate(Date releasedDate) {
        this.releasedDate = releasedDate;
    }
    
    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "edu.fpt.capstone.entity.Version[ id=" + id + " ]";
    }
    
}
