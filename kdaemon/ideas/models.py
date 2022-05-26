from django.db import models

# Create your models here.
class Idea(models.Model):
    title=models.CharField(max_length=160)
    description=models.TextField()
    creation_date=models.DateTimeField('date created')
    def __str__(self):
        return self.title