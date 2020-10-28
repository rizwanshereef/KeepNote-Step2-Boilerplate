package com.stackroute.keepnote.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.stackroute.keepnote.model.Note;

/*
 * This class is implementing the NoteDAO interface. This class has to be annotated with @Repository
 * annotation.
 * @Repository - is an annotation that marks the specific class as a Data Access Object, thus 
 * 				 clarifying it's role.
 * @Transactional - The transactional annotation itself defines the scope of a single database 
 * 					transaction. The database transaction happens inside the scope of a persistence 
 * 					context.  
 * */
@Repository
@Transactional
public class NoteDAOImpl implements NoteDAO {

	/*
	 * Autowiring should be implemented for the SessionFactory.
	 */

	public NoteDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Autowired
	SessionFactory sessionFactory;

	Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/*
	 * Save the note in the database(note) table.
	 */

	@Override
	public boolean saveNote(Note note) {
		// System.out.println("saveNote START:");
		boolean saveFlag = false;
		try {
			getSession().save(note);
			saveFlag = true;

		} catch (Exception e) {
		}

		return saveFlag;
	}

	/*
	 * Remove the note from the database(note) table.
	 */

	@Override
	public boolean deleteNote(int noteId) {

		try {
			getSession().createQuery("delete from Note where noteId =" + noteId).executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/*
	 * retrieve all existing notes sorted by created Date in descending
	 * order(showing latest note first)
	 */
	@Override
	public List<Note> getAllNotes() {

		List<Note> noteList = getSession().createQuery("from Note").list();
		return noteList;
	}

	/*
	 * retrieve specific note from the database(note) table
	 */
	@Override
	public Note getNoteById(int noteId) {
		List<Note> noteList = getSession().createCriteria(Note.class).add(Restrictions.idEq(noteId)).list();

		if (noteList != null && !noteList.isEmpty()) {
			return noteList.get(0);
		}
		return null;
	}

	/* Update existing note */

	@Override
	public boolean UpdateNote(Note note) {
		try {
			getSession().saveOrUpdate(note);
			return true;
		} catch (Exception e) {
		}
		return false;
	}

}