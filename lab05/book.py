import os
from sqlalchemy import create_engine, Column, Integer, String, Float
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Connecting to an SQLite database (or creating it if it doesn't exist)
current_directory = os.path.dirname(os.path.abspath(__file__))
database_path = os.path.join(current_directory, "database.db")  # Specify database file name
engine = create_engine(f"sqlite:///{database_path}")

# Defining a Model for a ‘User’ Table:
Base = declarative_base()

class Book(Base):
    __tablename__ = 'books'  # Specifies the table name
    id = Column(Integer, primary_key=True)
    title = Column(String)
    author = Column(String)
    published_year = Column(Integer)
    price = Column(Float)

# Create all tables defined with Base
Base.metadata.create_all(engine)

# Bind session to the engine
Session = sessionmaker(bind=engine)
session = Session()

# Create a new book instance and add it to the session
new_book = Book(title="The Great Gatsby", author="F. Scott Fitzgerald", published_year=1925, price=10.99)
session.add(new_book)
session.commit()
# Create a new book instance and add it to the session
new_book = Book(title="To Kill a Mockingbird", author="Harper Lee", published_year=1922, price=11.99)
session.add(new_book)
session.commit()
# Create a new book instance and add it to the session
new_book = Book(title="HAnlod", author="skjfe fdijf", published_year=1945, price=50.89)
session.add(new_book)
session.commit()
# Create a new book instance and add it to the session
new_book = Book(title="The dkjsk dsjd", author="cdgf gfd", published_year=1225, price=17.99)
session.add(new_book)
session.commit()

# Fetch all books and print them
books = session.query(Book).all()
for book in books:
    print(book.title, book.author, book.published_year, book.price)

# Update the price of the book
book = session.query(Book).filter_by(title="The Great Gatsby").first()
book.price = 12.99
session.commit()  # Save the changes

# Delete the book
book = session.query(Book).filter_by(title="The Great Gatsby").first()
session.delete(book)  # Mark the book for deletion
session.commit()  # Commit the deletion

print("")
# Fetch all books and print them
books = session.query(Book).all()
for book in books:
    print(book.title, book.author, book.published_year, book.price)