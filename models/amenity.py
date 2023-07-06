#!/usr/bin/python3
""" State Module for HBNB project """
from models.base_model import BaseModel
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship


class Amenity(BaseModel):
    """ amenity class """
    __tablename__ = 'amenities'
    name = Column(String(128), nullable=False)
    place_amenties = relationship('Place', secondary='place_amenity',
                                  viewonly=False)
