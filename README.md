# Secret Santa

You know the drill, it's Christmas and your group of friends are ready to get picking this years Secret Santas. But someone always picks themselves and Nathan ends up picking his girlfriend Helen; it all gets a bit tedious.

Fear not! `SecretSantaGenerator` will generate every possible outcome that you require and mearly ask you for the year you would like to draw for.

```Ruby
# Who's involved?
people = %w( Tom Sarah Helen Nathan Ben Natalie Fred Cat )

# Should any people not pick each other?
contraints = [ [ "Tom", "Sarah" ], [ "Nathan", "Helen"] ]

# Get picking!
generator = SecretSantaGenerator.new people, constraints

if generator.valid?
  recipients = generator.pick(2013)
  matches = Hash[people.zip(recipients)]

  # If you want to cheat and see who has who...
  puts matches.map { |match| match.join(' => ') }.join("\n");
end
```

## TODO

Turn this into a gem before so that the whole world can benifit! The server and Gem are pretty much done, however, some finishing touches are required which I just don't have time for right now.