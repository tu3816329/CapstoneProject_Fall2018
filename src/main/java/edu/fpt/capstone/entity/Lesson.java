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
@Table(name = "lesson", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Lesson.findAll", query = "SELECT l FROM Lesson l")
    , @NamedQuery(name = "Lesson.findById", query = "SELECT l FROM Lesson l WHERE l.id = :id")
    , @NamedQuery(name = "Lesson.findByLessonTitle", query = "SELECT l FROM Lesson l WHERE l.lessonTitle = :lessonTitle")})
public class Lesson implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "lesson_title", nullable = false, length = 100)
    private String lessonTitle;
    @Basic(optional = false)
    @Lob
    @Column(name = "lesson_content", nullable = false, length = 2147483647)
    private String lessonContent;
    @JoinColumn(name = "chapter_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Chapter chapterId;
    @JoinColumn(name = "version_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Version versionId;

    public Lesson() {
    }

    public Lesson(Integer id) {
        this.id = id;
    }

    public Lesson(Integer id, String lessonTitle, String lessonContent) {
        this.id = id;
        this.lessonTitle = lessonTitle;
        this.lessonContent = lessonContent;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLessonTitle() {
        return lessonTitle;
    }

    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }

    public String getLessonContent() {
        return lessonContent;
    }

    public void setLessonContent(String lessonContent) {
        this.lessonContent = lessonContent;
    }

    public Chapter getChapterId() {
        return chapterId;
    }

    public void setChapterId(Chapter chapterId) {
        this.chapterId = chapterId;
    }

    public Version getVersionId() {
        return versionId;
    }

    public void setVersionId(Version versionId) {
        this.versionId = versionId;
    }

    @Override
    public String toString() {
        return "entity.Lesson[ id=" + id + " ]";
    }
    
}
