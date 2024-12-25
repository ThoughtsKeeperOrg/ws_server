 defmodule KafkaClient do
  use Broadway

  def start_link(_opts) do
    kafka_host = (System.get_env("KAFKA_HOST") || "localhost") |> String.to_atom
    kafka_port = (System.get_env("KAFKA_PORT") || "9092") |> String.to_integer
    hosts = Keyword.new([{kafka_host, kafka_port}])

    IO.inspect("KafkaClient is trying to connect to #{inspect(hosts)}")

    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwayKafka.Producer, [
          hosts: hosts,
          group_id: "group_1",
          topics: ["entities_updates"],
        ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ]
    )
  end

  def handle_message(_, message, _) do
    IO.puts("*************")
    IO.inspect("Processing #{inspect(message)}")
    IO.inspect(message.data, label: "Got message")
    IO.puts("*************")
    r = WsServerWeb.Endpoint.broadcast("room:lobby", "new_msg", Jason.decode!(message.data) )
    IO.inspect(r)
    IO.puts("*************")
    
    message
  end
end