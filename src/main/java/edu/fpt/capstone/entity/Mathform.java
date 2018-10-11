/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.fpt.capstone.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "mathform", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MathForm.findAll", query = "SELECT m FROM Mathform m")
    , @NamedQuery(name = "MathForm.findById", query = "SELECT m FROM Mathform m WHERE m.id = :id")
    , @NamedQuery(name = "MathForm.findByTitle", query = "SELECT m FROM Mathform m WHERE m.mathformTitle = :mathformTitle")})
public class Mathform implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "mathform_title", nullable = false, length = 255)
    private String mathformTitle;
    @Basic(optional = false)
    @Lob
    @Column(name = "mathform_content", nullable = false, length = 2147483647)
    private String mathformContent;
    @JoinColumn(name = "lesson_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Lesson lessonId;
    @JoinColumn(name = "version_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Version versionId;

    public Mathform() {
    }

    public Mathform(Integer id) {
        this.id = id;
    }

    public Mathform(Integer id, String mathformTitle, String mathformContent) {
        this.id = id;
        this.mathformTitle = mathformTitle;
        this.mathformContent = mathformContent;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMathformTitle() {
        return mathformTitle;
    }

    public void setMathformTitle(String mathformTitle) {
        this.mathformTitle = mathformTitle;
    }

    public String getMathformContent() {
        return mathformContent;
    }

    public void setMathformContent(String mathformContent) {
        this.mathformContent = mathformContent;
    }

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
    }

    public Version getVersionId() {
        return versionId;
    }

    public void setVersionId(Version versionId) {
        this.versionId = versionId;
    }

    @Override
    public String toString() {
        return "entity.MathForm[ id=" + id + " ]";
    }
    
}
