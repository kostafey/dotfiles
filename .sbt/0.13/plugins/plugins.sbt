addSbtPlugin("io.get-coursier" % "sbt-coursier" % "2.0.0-RC6-8")

addCompilerPlugin(
  "org.scalamacros" % "paradise" % "2.1.0" cross CrossVersion.full
)
