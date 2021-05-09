defmodule Caterpie.QMS do
  @moduledoc """
  The QMS context.
  """

  import Ecto.Query, warn: false
  alias Caterpie.Repo

  alias Caterpie.QMS.Quiz

  @doc """
  Returns the list of quizzes.

  ## Examples

      iex> list_quizzes()
      [%Quiz{}, ...]

  """
  def list_quizzes do
    Repo.all(Quiz)
  end

  @doc """
  Gets a single quiz.

  Raises `Ecto.NoResultsError` if the Quiz does not exist.

  ## Examples

      iex> get_quiz!(123)
      %Quiz{}

      iex> get_quiz!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quiz!(id), do: Repo.get!(Quiz, id)

  @doc """
  Creates a quiz.

  ## Examples

      iex> create_quiz(%{field: value})
      {:ok, %Quiz{}}

      iex> create_quiz(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quiz(attrs \\ %{}) do
    %Quiz{}
    |> Quiz.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quiz.

  ## Examples

      iex> update_quiz(quiz, %{field: new_value})
      {:ok, %Quiz{}}

      iex> update_quiz(quiz, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quiz(%Quiz{} = quiz, attrs) do
    quiz
    |> Quiz.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quiz.

  ## Examples

      iex> delete_quiz(quiz)
      {:ok, %Quiz{}}

      iex> delete_quiz(quiz)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quiz(%Quiz{} = quiz) do
    Repo.delete(quiz)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quiz changes.

  ## Examples

      iex> change_quiz(quiz)
      %Ecto.Changeset{data: %Quiz{}}

  """
  def change_quiz(%Quiz{} = quiz, attrs \\ %{}) do
    Quiz.changeset(quiz, attrs)
  end

  alias Caterpie.QMS.QuestionInfo

  @doc """
  Returns the list of questions_info.

  ## Examples

      iex> list_questions_info()
      [%QuestionInfo{}, ...]

  """
  def list_questions_info do
    Repo.all(QuestionInfo)
  end

  @doc """
  Gets a single question_info.

  Raises `Ecto.NoResultsError` if the Question info does not exist.

  ## Examples

      iex> get_question_info!(123)
      %QuestionInfo{}

      iex> get_question_info!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_info!(id), do: Repo.get!(QuestionInfo, id)

  @doc """
  Creates a question_info.

  ## Examples

      iex> create_question_info(%{field: value})
      {:ok, %QuestionInfo{}}

      iex> create_question_info(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question_info(attrs \\ %{}) do
    %QuestionInfo{}
    |> QuestionInfo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question_info.

  ## Examples

      iex> update_question_info(question_info, %{field: new_value})
      {:ok, %QuestionInfo{}}

      iex> update_question_info(question_info, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question_info(%QuestionInfo{} = question_info, attrs) do
    question_info
    |> QuestionInfo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question_info.

  ## Examples

      iex> delete_question_info(question_info)
      {:ok, %QuestionInfo{}}

      iex> delete_question_info(question_info)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question_info(%QuestionInfo{} = question_info) do
    Repo.delete(question_info)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question_info changes.

  ## Examples

      iex> change_question_info(question_info)
      %Ecto.Changeset{data: %QuestionInfo{}}

  """
  def change_question_info(%QuestionInfo{} = question_info, attrs \\ %{}) do
    QuestionInfo.changeset(question_info, attrs)
  end
end
