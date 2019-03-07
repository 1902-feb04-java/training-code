package com.revature;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class Driver {

	public static void main(String[] args) {
		Configuration configuration = new Configuration().configure();
		StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder()
				.applySettings(configuration.getProperties());
		SessionFactory sf = configuration.buildSessionFactory(ssrb.build());
		Session session = sf.openSession();
		session.beginTransaction();
		
		/* Saving new sandwich with each run */
		Sandwich firstSandwich = new Sandwich();
		firstSandwich.setName("ravioli");
		System.out.println(firstSandwich.toString());
		session.save(firstSandwich);
		System.out.println(firstSandwich.toString());
		
		Combo firstCombo = new Combo(0, 4.99, firstSandwich);
		session.save(firstCombo);
		System.out.println(firstCombo);
		
		System.out.println("Fetching sandwich 1");
		Sandwich fetchedSandwich = (Sandwich) session.get(Sandwich.class, 1);
		System.out.println(fetchedSandwich);
		fetchedSandwich.setName("burrito");
		session.update(fetchedSandwich);
		System.out.println("fetching sandwich 1 again");
		fetchedSandwich = (Sandwich) session.get(Sandwich.class, 1);
		System.out.println(fetchedSandwich);
		
		session.getTransaction().commit();
		session.close();
		
		session = sf.openSession();
		session.beginTransaction();
		fetchedSandwich = (Sandwich) session.get(Sandwich.class, 1);
		/* Query - use custom HQL */
//		double userDouble = 3.99;
//		List<Combo> combos = session.createQuery("from Combo where price > :var")
//				.setDouble("var", userDouble).list();
//		System.out.println(combos);
		
		/* Criteria - programmatic select */
//		List<Sandwich> sandwiches = session.createCriteria(Sandwich.class)
//				.add(Restrictions.between("id", 1, 7))
//				.addOrder(Order.desc("id"))
//				.setProjection(Projections.count("id"))
//				.list();
//		System.out.println(sandwiches);
		
		/* Fetch and update sandwich */
//		Sandwich fetchedSandwich = (Sandwich) session.get(Sandwich.class, 2);
//		System.out.println(fetchedSandwich);
//		fetchedSandwich.setName("BLT");
//		session.update(fetchedSandwich);
		
		/* Get then delete Sandwich */
//		Sandwich deleteSandwich = (Sandwich) session.get(Sandwich.class, 3);
//		session.delete(deleteSandwich);

		session.getTransaction().commit();
		session.close();
		sf.close();
	}

}
