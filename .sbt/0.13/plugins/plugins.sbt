addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.12")
addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC1")

addCompilerPlugin(
  "org.scalamacros" % "paradise" % "2.1.0" cross CrossVersion.full
)
