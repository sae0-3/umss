from figures.Figura import Figura
from OpenGL.GL import (
    GL_QUADS,
    glBegin,
    glEnd,
    glTexCoord2f,
    glVertex3f,
)


class Plano(Figura):
    def __init__(self, size=1.0, color=(0.0, 0.5, 1.0), texture=None, name=None):
        super().__init__(name, color, texture)
        self.size = size

    def draw_shape(self):
        glBegin(GL_QUADS)
        glTexCoord2f(0.0, 0.0)
        glVertex3f(-self.size, -self.size, 0.0)
        glTexCoord2f(1.0, 0.0)
        glVertex3f(self.size, -self.size, 0.0)
        glTexCoord2f(1.0, 1.0)
        glVertex3f(self.size, self.size, 0.0)
        glTexCoord2f(0.0, 1.0)
        glVertex3f(-self.size, self.size, 0.0)
        glEnd()
