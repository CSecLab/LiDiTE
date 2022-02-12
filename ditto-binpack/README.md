# ditto-binpack

[Eclipse Ditto](https://www.eclipse.org/ditto) is an open source solution for implementing the digital twin pattern.

The original deployment consists of multiple microservices, with interactions handled via a distributed actors framework.

Such architecture is matching the original project goals of massive scalability but does not fit well in deployments with no such objectives.

Still, in order to leverage this state of the art solution in our project, we decided to find a way to reduce the resource consumption of the entire deployment.

## Why binpacking

Each Ditto microservice is a Java program, execution of a Java program requires an application level virtualization solution known as a Java Virtual Machine (JVM).

Each JVM handles execution via interpretation and JIT compilation, while keeping in memory metadata about parsed class hierarchies and so on.

In order to reduce this fixed overhead one way could be to create a single Java program bundling inside it other subprograms, such program can be executed on a single JVM, reducing the aforementioned computational cost.

## Alternatives

Other alternatives have been considered, namely:

- Changing the JVM implementation from Oracle's OpenJDK distribution with Eclipse Open J9.
- Leveraging Oracle's OpenJDK AppCDS feature.

But these attempts yielded increased resource usage with respect to the binpacking implementation.
