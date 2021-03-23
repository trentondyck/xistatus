from django.db import models

# Create your models here.
class Linkshell(models.Model):
    """ Group users by linkshell. """
    text = models.CharField(max_length=200)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        """ Returns the linkshell name """
        return self.text

class Member(models.Model):
    """ Individual member Online status, Zone, Hostname, last updated date """
    linkshell = models.ForeignKey(Linkshell, on_delete=models.CASCADE)
    status = models.BooleanField(default=False, blank=True, null=True)
    zone = models.TextField()
    character = models.TextField()
    hostname = models.TextField()
    date_modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        """ Returns the member status """
        return self.character
        #return self.linkshell.text, self.status, self.zone, self.hostname, self.date_modified
