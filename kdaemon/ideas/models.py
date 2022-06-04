from django.db import models
import django.utils
# Create your models here.
class Idea(models.Model):
    title=models.CharField(max_length=160)
    description=models.TextField()
    creation_date=models.DateTimeField('date created', default=django.utils.timezone.now)
    def __str__(self):
        return self.title